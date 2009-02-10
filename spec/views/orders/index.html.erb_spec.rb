require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/orders/index.html.erb" do
  include OrdersHelper
  
  before(:each) do
    assigns[:orders] = [
      stub_model(Order,
        :brick_id => 1,
        :ip_address => "value for ip_address",
        :first_name => "value for first_name",
        :last_name => "value for last_name",
        :card_type => "value for card_type"
      ),
      stub_model(Order,
        :brick_id => 1,
        :ip_address => "value for ip_address",
        :first_name => "value for first_name",
        :last_name => "value for last_name",
        :card_type => "value for card_type"
      )
    ]
  end

  it "should render list of orders" do
    render "/orders/index.html.erb"
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for ip_address".to_s, 2)
    response.should have_tag("tr>td", "value for first_name".to_s, 2)
    response.should have_tag("tr>td", "value for last_name".to_s, 2)
    response.should have_tag("tr>td", "value for card_type".to_s, 2)
  end
end

