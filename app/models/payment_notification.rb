class PaymentNotification < ActiveRecord::Base
  belongs_to :brick
  serialize :params
  after_create :mark_brick_as_purchased
  
  private
  def mark_brick_as_purchased
    brick.update_attribute(:purchased_at, Time.now) if status == 'OK'
  end
end
