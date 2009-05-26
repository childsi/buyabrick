ExceptionNotifier.sender_address = %("Buy-a-Brick Error" <error@buyabrick.childsifoundation.org>)
ExceptionNotifier.email_prefix = "[Buy-a-Brick] "

config_path = File.join(RAILS_ROOT, 'config', 'exception_notification.yml')
if File.exists?(config_path)
  config = YAML.load_file(config_path)
  ExceptionNotifier.exception_recipients = config[:recepients]
else
  ExceptionNotifier.exception_recipients = ENV['EXCEPTION_NOTIFIER_RECEPIENTS']
end
