class Brick < ActiveRecord::Base
  has_one :order
  
  validates_presence_of :name
  validate :valid_email?
  
  def self.wall
    Brick.find(:all, :conditions => 'purchased_at IS NOT NULL', :order => 'purchased_at')
  end
  
  def valid_email?
    TMail::Address.parse(email) 
  rescue
    errors.add_to_base("Must be a valid email")
  end
  
  def prepare_order(order_attributes)
    if order.nil?
      build_order(order_attributes)
    else
      order.attributes = order_attributes
      order
    end
  end
end
