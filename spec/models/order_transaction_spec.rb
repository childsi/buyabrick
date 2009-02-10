require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrderTransaction do
  before(:each) do
    @valid_attributes = {
      :order_id => 1,
      :action => "value for action",
      :amount => 1,
      :success => false,
      :authorization => "value for authorization",
      :message => "value for message",
      :params => "value for params"
    }
  end

  it "should create a new instance given valid attributes" do
    OrderTransaction.create!(@valid_attributes)
  end
end
