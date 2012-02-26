# encoding: utf-8

require 'spec_helper'

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
  
  describe "displaying value" do
    before(:each) do
      @brick = Factory(:brick)
    end
    
    it "should have a title" do
      @brick.title.should == "Display name has donated £2.50 to the wall"
    end
  end
  
  describe "hiding value" do
    before(:each) do
      @brick = Factory(:brick, :show_value => false)
    end
    
    it "should have a title" do
      @brick.title.should == "Display name has donated to the wall"
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
  
  ['foo', 'foo bar', 'foo@bar@'].each do |address|
    it "should be invalid with a bad email address" do
      @brick.email = address
      @brick.should_not be_valid
      @brick.errors.on(:email).should == 'is invalid'
    end
  end
end
