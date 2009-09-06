require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PaymentNotification do
  describe "setting up twitter message" do
    before(:each) do
      @payment_notification = PaymentNotification.new(
        :brick => Brick.new(
          :url_key => 'foo',
          :message => 'a message',
          :display_name => 'name'
        )
      )
    end
    
    it "should create the right twitter message for the brick" do
      @payment_notification.send(:twitter_message).should == 'name: a message http://buyabrick.heroku.com/bricks/foo'
    end
    
    it "should create the right twitter message when the brick has a twitter username" do
      @payment_notification.brick.twitter = 'twitter'
      @payment_notification.send(:twitter_message).should == '@twitter a message http://buyabrick.heroku.com/bricks/foo'
    end
    
    it "should create the right twitter message when there's a long message" do
      @payment_notification.brick.message = 'a'*140
      @payment_notification.send(:twitter_message).size.should == 140
      @payment_notification.send(:twitter_message).should == 'name: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa... http://buyabrick.heroku.com/bricks/foo'
    end
    
  end
end
