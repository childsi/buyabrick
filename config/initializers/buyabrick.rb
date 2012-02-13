require 'will_paginate'

config_path = File.join(RAILS_ROOT, 'config', 'buyabrick.yml')
if File.exists?(config_path)
  buyabrick_options = YAML.load_file(config_path)
else
  buyabrick_options = {
    :admin_username => ENV['ADMIN_USERNAME'],
    :admin_password => ENV['ADMIN_PASSWORD'],
  }
end
ADMIN_USERNAME = buyabrick_options[:admin_username]
ADMIN_PASSWORD = buyabrick_options[:admin_password]

raise 'No admin username/password set' unless (ADMIN_USERNAME and ADMIN_PASSWORD)
raise 'Invalid username/password set' if (ADMIN_USERNAME == ADMIN_PASSWORD)
