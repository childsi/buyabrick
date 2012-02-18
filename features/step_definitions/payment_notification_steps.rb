When /^the following (.+) payment notification is sent:$/ do |foo, table|
  p foo
  crypt = GATEWAY.send(:encrypt_for_protx, table.hashes.first)
  p crypt
end

Given /^given that Just Giving has the following donation:$/ do |table|
  table.hashes.each do |row|
    donation = stub_everything(:details => row)
    JustGiving::Donation.stubs(:new).returns(donation)
  end
end
