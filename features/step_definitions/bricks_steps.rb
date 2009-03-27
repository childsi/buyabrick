Given /^I am logged in as an admin$/ do
  visit login_path
  fill_in "user", :with => 'foo'
  fill_in "password", :with => 'bar'
  click_button
end

Given /I am on the new bricks page/ do
  visit "/bricks/new"
end

Given /^the following bricks:$/ do |brick|
  Brick.create!(brick.hashes)
end

When /^I fill in the following brick details:$/ do |brick|
  brick.hashes.each do |line|
    line.each { |f,v| fill_in("brick[#{f}]", :with => v) }
  end
end

When /^I delete the (\d+)(?:st|nd|rd|th) bricks$/ do |pos|
  visit bricks_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^the current brick should be saved$/ do
  Brick.find(session[:brick_id]).should_not be_new_record
end

Then /^I should see the following bricks:$/ do |bricks|
  bricks.raw[1..-1].each_with_index do |row, i|
    row.each_with_index do |cell, j|
      response.should have_selector("table > tr:nth-child(#{i+2}) > td:nth-child(#{j+1})") { |td|
        td.inner_text.should == cell
      }
    end
  end
end
