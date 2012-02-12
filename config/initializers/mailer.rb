# require "smtp_tls"

config_path = File.join(RAILS_ROOT, 'config', 'mailer.yml')
if File.exists?(config_path)
  config = YAML.load_file(config_path)
else
  config = {
    :address => ENV['MAILER_ADDRESS'] || 'smtp.gmail.com',
    :port => ENV['MAILER_PORT'] || '587',
    :user_name => ENV['MAILER_USER_NAME'],
    :password => ENV['MAILER_PASSWORD'],
    :authentication => ENV['MAILER_AUTHENTICATION'] || 'plain',
  }
end
ActionMailer::Base.smtp_settings = config
