require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrdersController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "orders", :action => "index").should == "/orders"
    end
  
    it "should map #new" do
      route_for(:controller => "orders", :action => "new").should == "/orders/new"
    end
  
    it "should map #show" do
      route_for(:controller => "orders", :action => "show", :id => 1).should == "/orders/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "orders", :action => "edit", :id => 1).should == "/orders/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "orders", :action => "update", :id => 1).should == "/orders/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "orders", :action => "destroy", :id => 1).should == "/orders/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/orders").should == {:controller => "orders", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/orders/new").should == {:controller => "orders", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/orders").should == {:controller => "orders", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/orders/1").should == {:controller => "orders", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/orders/1/edit").should == {:controller => "orders", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/orders/1").should == {:controller => "orders", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/orders/1").should == {:controller => "orders", :action => "destroy", :id => "1"}
    end
  end
end
