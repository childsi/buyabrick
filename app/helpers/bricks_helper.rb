module BricksHelper
  def justgiving_link(brick)
    if Rails.env.production?
      justgiving_path = "http://www.justgiving.com/donation/direct/charity/185222"
    else
      justgiving_path = "http://v3-sandbox.justgiving.com/donation/direct/charity/185222"
    end
    amount = brick.value/100.0
    exit_url = thanks_brick_url(brick)
    return "#{justgiving_path}?amount=#{amount}&frequency=Single&exitUrl=#{CGI.escape(exit_url)}"
  end
end
