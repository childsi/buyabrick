class ProtxForm
  attr_accessor :encryption_key, :url, :protocol, :vendor, :app_key
  
  def initialize(params={})
    self.url = params[:url]
    self.vendor = params[:vendor]
    self.protocol = params[:protocol] || '2.23'
    self.encryption_key = params[:encryption_key]
    self.app_key = params[:app_key] || `hostname`.strip
  end
  
  def form_fields(object, success_url, failure_url)
    object_details = object.protx_hash.merge(
      'VendorTxCode' => "#{app_key}-#{object.class.name.tableize}-#{object.id}",
      'AllowGiftAid' => '1',
      'SuccessURL' => success_url,
      'FailureURL' => failure_url
    )
    {
      'TXType' => 'PAYMENT',
      'VPSProtocol' => protocol,
      'Vendor' => vendor,
      'Crypt' => encrypt_for_protx(object_details)
    }
  end
  
  def parse_response(crypt)
    params = decrypt_from_protx(crypt)
    obj_key, obj_id = "#{$2.singularize}_id".to_sym, $3 if params['VendorTxCode'] =~ /(.*?)-(.*?)-(\d+)/
    {
      :params => params, 
      :status => params['Status'],
      :transaction_id => params['TxAuthNo'],
      obj_key => obj_id
    }
  end
  
  private
  
  def decrypt_from_protx(crypt)
    string = Base64.decode64(crypt) ^ encryption_key
    hash = CGI.parse(string)
    hash.each { |k,v| hash[k] = v.first if v.size==1 }
    hash
  end
  
  def encrypt_for_protx(values)
    string = values.map { |k,v| "#{k}=#{v}" }.join('&')
    Base64.encode64(string ^ encryption_key).gsub("\n", '')
  end
end
