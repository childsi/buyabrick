class Brick < ActiveRecord::Base
  has_random_key :url_key, :size => 4
  validates_uniqueness_of :url_key
  
  validates_presence_of :display_name, :first_name, :last_name
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
      when 0..9_99 then self.colour = 'a'
      when 10_00..19_99 then self.colour = 'b'
      when 20_00..49_99 then self.colour ||= ['c1', 'c2', 'c3', 'c4'].rand
      when 50_00..500_00 then self.colour = 'd'
    end
  end
  
  def can_set_colour?
    (value and value >= 20_00 and value < 49_99)
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def twitter=(username)
    username = $1 if username =~ /@(.*)/
    super(username)
  end
  
  def twitter_message
    user = twitter.blank? ? "name:" : "@#{twitter}"
    "#{user} #{message}"
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
  
  def to_xml(options = {})
    to_hash.to_xml(options)
  end
  
  def to_hash
    return {} if naughty?
    hash = {
      :url_key => url_key,
      :first_name => first_name,
      :last_name => last_name,
      # :display_name => display_name,
      :colour => colour,
      :icon_id => icon_id,
      :message => message,
    }
    hash[:value] = value_in_pounds if show_value?
    hash[:url] = url unless url.blank?
    hash[:twitter] = twitter unless twitter.blank?
    hash
  end
  
  def protx_hash
    hash = {
      'Amount' => value_in_pounds,
      'Currency' => 'GBP',
      'CustomerName' => name,
      'Description' => "Buy-a-brick: #{message}",
      'BillingSurname' => (billing_surname || 'Surname'),
      'BillingFirstnames' => (billing_firstnames || 'Name'),
      'BillingAddress1' => (billing_address1 || 'Address'),
      'BillingAddress2' => (billing_address2 || nil),
      'BillingCity' => (billing_city || 'City'),
      'BillingPostCode' => (billing_post_code || 'Postcode'),
      'BillingCountry' => (billing_country || 'GB'),
      'DeliverySurname' => (billing_surname || 'Surname'),
      'DeliveryFirstnames' => (billing_firstnames || 'Name'),
      'DeliveryAddress1' => (billing_address1 || 'Address'),
      'DeliveryAddress2' => (billing_address2 || nil),
      'DeliveryCity' => (billing_city || 'City'),
      'DeliveryPostCode' => (billing_post_code || 'Postcode'),
      'DeliveryCountry' => (billing_country || 'GB'),
    }
    hash['CustomerEMail'] = email unless email.blank?
    hash
  end
end
