class PaymentNotification < ActiveRecord::Base
  belongs_to :brick
  serialize :params
  after_create :mark_brick_as_purchased
  
  def self.create_by_brick_and_justgiving(brick, params)
    status = (params['status'] == 'Accepted' or params['status'] == 'Pending') ? 'OK' : params['status']
    PaymentNotification.create(:brick => brick, :status => status, :params => params)
  end
  
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
      logger.info("Brick #{@brick.url_key} purchased successfully")
      @brick.update_attribute(:purchased_at, Time.now)
      
      begin
        FuKing::Twitter.update(twitter_message)
      rescue => e
        logger.warn("Error tweeting brick #{@brick.url_key}: #{e.message}")
      end
    else
      logger.info("Brick #{@brick.url_key} purchase unsuccessful: #{status}")
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
