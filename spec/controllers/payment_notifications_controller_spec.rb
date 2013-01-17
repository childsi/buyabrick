require 'spec_helper'

describe PaymentNotificationsController do
  describe "responding to GET return" do
    it "should do something with the callback" do
      @brick = Factory(:brick)
      
      donation = %[{
        "ref": "my-sdi-ref",
        "donationId": 1234,
        "donationRef": "35626",
        "status": "Accepted",
        "amount": 2.00
      }]
      FakeWeb.register_uri(:get, "https://api-sandbox.justgiving.com/a6c422f5/v1/donation/abcd", :body => donation)
      
      get :return, id: @brick.to_param, donationId: 'abcd'
      
      @payment_notification = PaymentNotification.last
      @payment_notification.status.should == 'OK'
      @payment_notification.params['amount'].should == 2.0
    end
  end
end
