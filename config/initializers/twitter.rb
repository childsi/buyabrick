# 
# unless File.exist?(FuKing::Twitter.config_file)
#   FuKing::Twitter.instance_eval do
#     def configs 
#       { :read_url => ENV['TWITTER_READ_URL'],
#         :write_url => ENV['TWITTER_WRITE_URL'],
#         :development_uri => ENV['TWITTER_DEVELOPMENT_URI'],
#         :test_uri => ENV['TWITTER_TEST_URI'],
#         :production_uri => ENV['TWITTER_PRODUCTION_URI']
#       }
#     end
#   end
# end
# 
# TWITTER_USERNAME = $1 if FuKing::Twitter.send(:configs)[:read_url] =~ %r[http://twitter.com/statuses/user_timeline/(\w+).xml]
TWITTER_USERNAME = 'buyabrick'