When /^the following (.+) payment notification is sent:$/ do |foo, table|
  p foo
  crypt = GATEWAY.send(:encrypt_for_protx, table.hashes.first)
  p crypt
end
