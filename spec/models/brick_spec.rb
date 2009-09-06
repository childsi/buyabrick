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
      @brick.twitter_message.should == '@foo value for message'
    end
  end
  
  before(:each) do
    @valid_attributes = {
      :value => 250,
      :first_name => "first",
      :last_name => "last",
      :display_name => 'display name',
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
end
