require 'spec_helper'

describe BricksHelper do
  describe "#justgiving_link" do
    before(:each) do
      @brick = Factory(:brick)
    end
    
    it "should generate the url for the brick" do
      url = 'http://v3-sandbox.justgiving.com/donation/direct/charity/185222?' +
        "amount=2.5&frequency=Single&exitUrl=http%3A%2F%2Ftest.host%2Fbricks%2F#{@brick.url_key}%2Fthanks" + 
        "%3FdonationId%3DJUSTGIVING-DONATION-ID"
      helper.justgiving_link(@brick).should == url
    end
  end
end
