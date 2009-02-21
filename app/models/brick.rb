class Brick < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  validate :valid_email?
  
  validate do |b|
    b.errors.add(:value_in_pounds, "The minimum donation is £2.00") if b.value < 200
    b.errors.add(:value_in_pounds, "The maximum donation is £500. Please contact us directly at donations@childsifoundation.org if you wish to donate more.") if b.value > 500_00
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
