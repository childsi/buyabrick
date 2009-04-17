class Brick < ActiveRecord::Base
  has_random_key :url_key, :size => 4
  validates_uniqueness_of :url_key
  
  validates_presence_of :first_name, :last_name
  validate :valid_email?
  
  validate do |b|
    b.errors.add(:value_in_pounds, "The minimum donation is £2.50") if b.value < 250
    b.errors.add(:value_in_pounds, "The maximum donation is £500. Please contact us directly at donations@childsifoundation.org if you wish to donate more.") if b.value > 500_00
  end
  
  attr_accessor :billing_surname, :billing_firstnames, :billing_address1, :billing_address2, 
    :billing_city, :billing_post_code, :billing_country
  # validates_presence_of :billing_surname, :billing_firstname, :billing_address1, :billing_city, :billing_post_code, :on => :create
  
  def initialize(attributes = nil)
    super
    self.icon_id ||= 1
  end
  
  def before_save
    case value
      when 0..9_99 then self.colour = 'breeze'
      when 10_00..19_99 then self.colour = 'london'
      when 20_00..49_99 then self.colour ||= ['custom_a', 'custom_b', 'custom_c'].rand
      when 50_00..500_00 then self.colour = 'gold'
    end
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def twitter=(username)
    username = $1 if username =~ /@(.*)/
    super(username)
  end
  
  def twitter_message
    "#{twitter.blank? ? name : "@#{twitter}"} has just bought a brick"
  end
  
  def value_in_pounds
    value.nil? ? nil : format('%.2f', (value/100.0) || 0)
  end
  def value_in_pounds=(a)
    return if a.nil?
    a = a.to_f if a.kind_of? String
    self.value=(a*100).to_i
  end
  
  def valid_email?
    TMail::Address.parse(email) unless email.blank?
  rescue
    errors.add_to_base("Must be a valid email")
  end
  
  def to_param
    url_key
  end
  
  def protx_hash
    hash = {
      'Amount' => value_in_pounds,
      'Currency' => 'GBP',
      'CustomerName' => name,
      'Description' => "Buy-a-brick: #{message}",
      'BillingSurname' => (billing_surname || 'foo'),
      'BillingFirstnames' => (billing_firstnames || 'foo'),
      'BillingAddress1' => (billing_address1 || 'foo'),
      'BillingAddress2' => (billing_address2 || 'foo'),
      'BillingCity' => (billing_city || 'foo'),
      'BillingPostCode' => (billing_post_code || 'foo'),
      'BillingCountry' => (billing_country || 'GB'),
      'DeliverySurname' => (billing_surname || 'foo'),
      'DeliveryFirstnames' => (billing_firstnames || 'foo'),
      'DeliveryAddress1' => (billing_address1 || 'foo'),
      'DeliveryAddress2' => (billing_address2 || 'foo'),
      'DeliveryCity' => (billing_city || 'foo'),
      'DeliveryPostCode' => (billing_post_code || 'foo'),
      'DeliveryCountry' => (billing_country || 'GB'),
    }
    hash['CustomerEMail'] = email unless email.blank?
    hash
  end
end
