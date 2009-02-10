require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/orders/new.html.erb" do
  include OrdersHelper
  
  before(:each) do
    assigns[:order] = stub_model(Order,
      :new_record? => true,
      :brick_id => 1,
      :ip_address => "value for ip_address",
      :first_name => "value for first_name",
      :last_name => "value for last_name",
      :card_type => "value for card_type"
    )
  end

  it "should render new form" do
    render "/orders/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", orders_path) do
      with_tag("input#order_brick_id[name=?]", "order[brick_id]")
      with_tag("input#order_ip_address[name=?]", "order[ip_address]")
      with_tag("input#order_first_name[name=?]", "order[first_name]")
      with_tag("input#order_last_name[name=?]", "order[last_name]")
      with_tag("input#order_card_type[name=?]", "order[card_type]")
    end
  end
end


