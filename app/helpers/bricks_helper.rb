module BricksHelper
  def justgiving_link(brick)
    justgiving_path = case JustGiving::Configuration.environment
      when :sandbox then "http://v3-sandbox.justgiving.com/donation/direct/charity/185222"
      when :staging then "http://v3-staging.justgiving.com/donation/direct/charity/185222"
      else "http://www.justgiving.com/donation/direct/charity/185222"
    end
    amount = brick.value/100.0
    exit_url = return_payment_notification_url(brick) + "?donationId=JUSTGIVING-DONATION-ID"
    return "#{justgiving_path}?amount=#{amount}&frequency=Single&exitUrl=#{CGI.escape(exit_url)}"
  end
end
