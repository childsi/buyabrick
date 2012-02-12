module BricksHelper
  def justgiving_link(brick)
    if Rails.env.development?
      justgiving_path = "http://v3-sandbox.justgiving.com/donation/direct/charity/185222"
    elsif Rails.env.production?
      justgiving_path = "http://www.justgiving.com/donation/direct/charity/185222"
    end
    return url = "#{justgiving_path}?amount=#{brick.value/100}&frequency=Single&exitUrl=http%253a%252f%252flocalhost%253a3000/bricks/thanks/#{brick.url_key}" 
  end
end
