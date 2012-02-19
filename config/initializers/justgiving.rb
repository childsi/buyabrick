begin
  require 'just_giving'
rescue NameError => e
end

module JustGiving
  class Configuration
    ## The API endpoint
    def self.api_endpoint
      raise JustGiving::InvalidApplicationId.new if !application_id
      case environment
        when :sandbox then "https://api-sandbox.justgiving.com/#{application_id}"
        when :staging then "https://api-staging.justgiving.com/#{application_id}"
        else "https://api.justgiving.com/#{application_id}"
      end
    end
  end
end

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
