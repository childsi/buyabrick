require 'twitter'

config_path = File.join(RAILS_ROOT, 'config', 'twitter.yml')
if File.exists?(config_path)
  twitter_options = YAML.load_file(config_path)
else
  twitter_options = {
    :username           => ENV['TWITTER_USERNAME'],
    :consumer_key       => ENV['TWITTER_CONSUMER_KEY'],
    :consumer_secret    => ENV['TWITTER_CONSUMER_SECRET'],
    :oauth_token        => ENV['TWITTER_OAUTH_TOKEN'],
    :oauth_token_secret => ENV['TWITTER_OAUTH_TOKEN_SECRET']
  }
end

TWITTER_USERNAME = twitter_options[:username]
Twitter.configure do |config|
  config.consumer_key = twitter_options[:consumer_key]
  config.consumer_secret = twitter_options[:consumer_secret]
  config.oauth_token = twitter_options[:oauth_token]
  config.oauth_token_secret = twitter_options[:oauth_token_secret]
end
