require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/orders/show.html.erb" do
  include OrdersHelper
  before(:each) do
    assigns[:order] = @order = stub_model(Order,
      :brick_id => 1,
      :ip_address => "value for ip_address",
      :first_name => "value for first_name",
      :last_name => "value for last_name",
      :card_type => "value for card_type"
    )
  end

  it "should render attributes in <p>" do
    render "/orders/show.html.erb"
    response.should have_text(/1/)
    response.should have_text(/value\ for\ ip_address/)
    response.should have_text(/value\ for\ first_name/)
    response.should have_text(/value\ for\ last_name/)
    response.should have_text(/value\ for\ card_type/)
  end
end

