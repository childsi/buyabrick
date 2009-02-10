class Order < ActiveRecord::Base
  belongs_to :brick
  has_many :transactions, :class_name => 'OrderTransaction'
  
  attr_accessor :card_number, :card_verification
  
  validate_on_create :validate_card
  
  def purchase
    response = STANDARD_GATEWAY.purchase(value_in_pence, credit_card, purchase_options)
    transactions.create!(:action => 'purchase', :amount => value_in_pence, :response => response)
    brick.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end
  
  def value_in_pence
    (brick.value*100).round
  end
  
  private
  
  def purchase_options
    {
      :ip => ip_address,
      :order_id => "#{id}-#{Time.now.to_i}",
      :billing_address => {
        :name => "#{first_name} #{last_name}",
        :address1 => "123 High Street",
        :city => "London",
        :zip => "sw1 1ab",
      }
    }
  end
  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end
  
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end
end
