config_path = File.join(RAILS_ROOT, 'config', 'payment_gateway.yml')
if File.exists?(config_path)
  gateway_options = YAML.load_file(config_path)[RAILS_ENV.to_sym]
else
  gateway_options = {
    :url => ENV['PAYMENT_GATEWAY_URL'],
    :login => ENV['PAYMENT_GATEWAY_LOGIN'],
    :protocol => ENV['PAYMENT_GATEWAY_PROTOCOL'],
    :password => ENV['PAYMENT_GATEWAY_PASSWORD'],
    :encryption_key => ENV['PAYMENT_GATEWAY_KEY'],
  }
end
GATEWAY = ProtxForm.new(gateway_options)
