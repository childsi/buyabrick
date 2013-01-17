require 'just_giving'

config_path = File.join(RAILS_ROOT, 'config', 'justgiving.yml')
if File.exists?(config_path)
  justgiving_options = YAML.load_file(config_path)[RAILS_ENV.to_sym]
else
  justgiving_options = {
    :app_id => ENV['JG_APPID'],
    :environment => ENV['JG_ENVIRONMENT'].to_sym
  }
end

JustGiving::Configuration.application_id = justgiving_options[:app_id]
JustGiving::Configuration.environment = justgiving_options[:environment]

# adding aliases to Faraday JSON modules that have moved to FaradayMiddleware
Faraday::Response::JSON = FaradayMiddleware::ParseJson
Faraday::Request::EncodeJson = FaradayMiddleware::EncodeJson
