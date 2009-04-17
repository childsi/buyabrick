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
  
  describe "twittering" do
    it "should remove the @ from a username" do
      @brick.twitter = '@foo'
      @brick.twitter.should == 'foo'
      @brick.twitter_message.should == '@foo has just bought a brick'
    end
  end
  
  before(:each) do
    @valid_attributes = {
      :value => 250,
      :first_name => "first",
      :last_name => "last",
      :email => "foo@bar.com",
      :url => "value for url",
      :message => "value for message"
    }
    @brick = Brick.create!(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @brick.should_not be_nil
  end
  
  it "should set the default icon_id to 1" do
    @brick.icon_id.should == 1
  end
  
  describe "can set colour" do
    it "should return true when the value is between 20 and 50 pounds" do
      @brick.value = 25_00
      @brick.should be_can_set_colour
    end
    
    it "should return true when the value is 20 pounds" do
      @brick.value = 20_00
      @brick.should be_can_set_colour
    end
    
    it "should return true when the value is under 20 pounds" do
      @brick.value = 10_00
      @brick.should_not be_can_set_colour
    end
    
    it "should return true when the value is over 50 pounds" do
      @brick.value = 55_00
      @brick.should_not be_can_set_colour
    end
  end
end
