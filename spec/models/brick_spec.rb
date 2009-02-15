require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Brick do
  before(:each) do
    @brick = Brick.new
  end
  
  describe "setting value in pounds" do
    [1,'1',1.0,'1.00'].each do |value|
      it "to #{value} should set the value to 100" do
        @brick.value_in_pounds = value
        @brick.value.should == 100
      end
    end
  end
  
  before(:each) do
    @valid_attributes = {
      :value => 200,
      :name => "value for name",
      :email => "foo@bar.com",
      :url => "value for url",
      :message => "value for message"
    }
  end

  it "should create a new instance given valid attributes" do
    Brick.create!(@valid_attributes)
  end
end
