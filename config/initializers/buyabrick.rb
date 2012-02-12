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

charity_id_path = File.join(RAILS_ROOT, 'config', 'charity_id.yml')
if File.exists?(charity_id_path)
  charity_id = YAML.load_file(charity_id_path)
  CHARITY_ID = charity_id['id']
else
  CHARITY_ID = 0000000
end
