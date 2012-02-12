require 'spec_helper'

describe BricksController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "bricks", :action => "index").should == "/bricks"
    end
  
    it "should map #new" do
      route_for(:controller => "bricks", :action => "new").should == "/bricks/new"
    end
  
    it "should map #show" do
      route_for(:controller => "bricks", :action => "show", :id => "1").should == "/bricks/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "bricks", :action => "edit", :id => "1").should == "/bricks/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "bricks", :action => "update", :id => "1").should == {:path => "/bricks/1", :method => :put}
    end
  
    it "should map #destroy" do
      route_for(:controller => "bricks", :action => "destroy", :id => "1").should == {:path => "/bricks/1", :method => :delete }
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/bricks").should == {:controller => "bricks", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/bricks/new").should == {:controller => "bricks", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/bricks").should == {:controller => "bricks", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/bricks/1").should == {:controller => "bricks", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/bricks/1/edit").should == {:controller => "bricks", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/bricks/1").should == {:controller => "bricks", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/bricks/1").should == {:controller => "bricks", :action => "destroy", :id => "1"}
    end
  end
end
