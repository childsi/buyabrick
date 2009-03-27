class PaymentNotification < ActiveRecord::Base
  belongs_to :brick
  serialize :params
  after_create :mark_brick_as_purchased
  
  private
  
  def mark_brick_as_purchased
    if status == 'OK'
      logger.info("Brick #{brick.url_key} purchased successfully")
      brick.update_attribute(:purchased_at, Time.now)
      FuKing::Twitter.update("#{brick.name} has just bought a brick: #{brick_url}")
    else
      logger.info("Brick #{brick.url_key} purchase unsuccessful: #{status}")
    end
  end
  
  def brick_url
    "http://buyabrick.heroku.com/bricks/#{brick.url_key}"
  end
end
