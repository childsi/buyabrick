class PaymentNotification < ActiveRecord::Base
  belongs_to :brick
  serialize :params
  after_create :mark_brick_as_purchased
  
  def technical_error?
    (status == 'ERROR' or status == 'MALFORMED' or status == 'INVALID')
  end
  
  def payment_error?
    (status == 'NOTAUTHED' or status == 'REJECTED')
  end
  
  def aborted?
    status == 'ABORT'
  end
  
  private
  
  def mark_brick_as_purchased
    if status == 'OK'
      logger.info("Brick #{brick.url_key} purchased successfully")
      brick.update_attribute(:purchased_at, Time.now)
      
      FuKing::Twitter.update(twitter_message)
    else
      logger.info("Brick #{brick.url_key} purchase unsuccessful: #{status}")
    end
  end
  
  def twitter_message
    message = brick.twitter_message
    url = brick_url
    url = UrlShortener.shorten(brick_url) if message.size+brick_url.size+1 > 140
    correct_size = 140-url.size-1
    message = "#{message[0,correct_size-3]}..." if message.size > correct_size
    "#{message} #{url}"
  end
  
  def brick_url
    "http://buyabrick.childsifoundation.org/bricks/#{brick.url_key}"
  end
end
