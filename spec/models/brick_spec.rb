require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Brick do
  before(:each) do
    @valid_attributes = {
      :value => 1,
      :name => "value for name",
      :email => "value for email",
      :url => "value for url",
      :message => "value for message"
    }
  end

  it "should create a new instance given valid attributes" do
    Brick.create!(@valid_attributes)
  end
end
