require 'spec_helper'

describe PaymentNotification do
  describe "create from Just Giving" do
    before(:each) do
      @brick = Factory(:brick)
    end
    
    ['Accepted', 'Pending'].each do |status|
      describe "for a #{status} transaction" do
        before(:each) do
          @payment_notification = PaymentNotification.create_by_brick_and_justgiving @brick, { :status => status }
        end
      
        it "should be valid" do
          @payment_notification.should be_valid
        end
      
        it "should have an OK status" do
          @payment_notification.status.should == 'OK'
        end
        
        it "should have some JG params" do
          @payment_notification.params.should == { :status => status }
        end
        
        it "should have set the purchased at date on the brick" do
          @brick.purchased_at.should_not be_nil
        end
      end
    end
    
    ['Rejected', 'Cancelled', 'Refunded'].each do |status|
      describe "for a #{status} transaction" do
        before(:each) do
          @payment_notification = PaymentNotification.create_by_brick_and_justgiving @brick, { :status => status }
        end
      
        it "should be valid" do
          @payment_notification.should be_valid
        end
      
        it "should have the original status" do
          @payment_notification.status.should == status
        end
        
        it "should have some JG params" do
          @payment_notification.params.should == { :status => status }
        end
        
        it "should not have set the purchased at date on the brick" do
          @brick.purchased_at.should be_nil
        end
      end
    end
  end
  
  describe "setting up twitter message" do
    before(:each) do
      @payment_notification = PaymentNotification.new(
        :brick => Brick.new(
          :url_key => 'foo',
          :message => 'a message',
          :display_name => 'jane'
        )
      )
      UrlShortener.stub!(:shorten).with('http://buyabrick.childsifoundation.org/bricks/foo').and_return('http://bit.ly/abcd')
    end
    
    it "should create the right twitter message for the brick" do
      @payment_notification.send(:twitter_message).should == 'jane: a message http://buyabrick.childsifoundation.org/bricks/foo'
    end
    
    it "should create the right twitter message when the brick has a twitter username" do
      @payment_notification.brick.twitter = 'twitter'
      @payment_notification.send(:twitter_message).should == '@twitter a message http://buyabrick.childsifoundation.org/bricks/foo'
    end
    
    it "should create the right twitter message when there's a long message" do
      @payment_notification.brick.message = 'a'*140
      @payment_notification.send(:twitter_message).size.should == 140
      @payment_notification.send(:twitter_message).should == 'jane: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa... http://bit.ly/abcd'
    end
  end
end
