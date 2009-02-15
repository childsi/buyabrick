class Brick < ActiveRecord::Base
  validates_presence_of :name
  validate :valid_email?
  
  def value_in_pounds; value/100.0; end
  def value_in_pounds=(a)
    a = a.to_f if a.kind_of? String
    self.value=(a*100).to_i
  end
  
  validate do |b|
    b.errors.add(:value, "The minimum donation is £2.00") if b.value < 200
    b.errors.add(:value, "The maximum donation is £500.00, please contact us directly...") if b.value > 500_00
  end
  
  def self.wall
    Brick.find(:all, :conditions => 'purchased_at IS NOT NULL', :order => 'purchased_at')
  end
  
  def valid_email?
    TMail::Address.parse(email) unless email.blank?
  rescue
    errors.add_to_base("Must be a valid email")
  end
  
  def protx_hash
    hash = {
      'Amount' => value,
      'Currency' => 'GBP',
      'Description' => "Buy-a-brick: #{message}",
    }
    hash['CustomerEMail'] = email unless email.blank?
    hash
  end
end
