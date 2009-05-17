Then /^the "([^\"]*)" element should contain "([^\"]*)"$/ do |path, text|
  response.body.should have_tag(path, text)
end

Then /^the "([^\"]*)" element should contain today's date$/ do |path|
  response.body.should have_tag(path, Date.today.to_s)
end
