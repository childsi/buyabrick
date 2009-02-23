config_path = File.join(RAILS_ROOT, 'config', 'payment_gateway.yml')
if File.exists?(config_path)
  gateway_options = YAML.load_file(config_path)
  GATEWAY = ProtxForm.new(gateway_options[RAILS_ENV.to_sym])
else
  $stderr.puts "Payment gateway not set up"
end
