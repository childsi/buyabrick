require 'exception_notification'

ExceptionNotification::Notifier.sender_address = %("Buy-a-Brick Error" <error@buyabrick.childsifoundation.org>)
ExceptionNotification::Notifier.email_prefix = "[Buy-a-Brick] "

config_path = File.join(RAILS_ROOT, 'config', 'exception_notification.yml')
if File.exists?(config_path)
  config = YAML.load_file(config_path)
  ExceptionNotification::Notifier.exception_recipients = config[:recepients]
else
  ExceptionNotification::Notifier.exception_recipients = ENV['EXCEPTION_NOTIFIER_RECEPIENTS']
end
