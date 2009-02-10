require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrdersController do

  def mock_order(stubs={})
    @mock_order ||= mock_model(Order, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all orders as @orders" do
      Order.should_receive(:find).with(:all).and_return([mock_order])
      get :index
      assigns[:orders].should == [mock_order]
    end

    describe "with mime type of xml" do
  
      it "should render all orders as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Order.should_receive(:find).with(:all).and_return(orders = mock("Array of Orders"))
        orders.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested order as @order" do
      Order.should_receive(:find).with("37").and_return(mock_order)
      get :show, :id => "37"
      assigns[:order].should equal(mock_order)
    end
    
    describe "with mime type of xml" do

      it "should render the requested order as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Order.should_receive(:find).with("37").and_return(mock_order)
        mock_order.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new order as @order" do
      Order.should_receive(:new).and_return(mock_order)
      get :new
      assigns[:order].should equal(mock_order)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested order as @order" do
      Order.should_receive(:find).with("37").and_return(mock_order)
      get :edit, :id => "37"
      assigns[:order].should equal(mock_order)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created order as @order" do
        Order.should_receive(:new).with({'these' => 'params'}).and_return(mock_order(:save => true))
        post :create, :order => {:these => 'params'}
        assigns(:order).should equal(mock_order)
      end

      it "should redirect to the created order" do
        Order.stub!(:new).and_return(mock_order(:save => true))
        post :create, :order => {}
        response.should redirect_to(order_url(mock_order))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved order as @order" do
        Order.stub!(:new).with({'these' => 'params'}).and_return(mock_order(:save => false))
        post :create, :order => {:these => 'params'}
        assigns(:order).should equal(mock_order)
      end

      it "should re-render the 'new' template" do
        Order.stub!(:new).and_return(mock_order(:save => false))
        post :create, :order => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested order" do
        Order.should_receive(:find).with("37").and_return(mock_order)
        mock_order.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :order => {:these => 'params'}
      end

      it "should expose the requested order as @order" do
        Order.stub!(:find).and_return(mock_order(:update_attributes => true))
        put :update, :id => "1"
        assigns(:order).should equal(mock_order)
      end

      it "should redirect to the order" do
        Order.stub!(:find).and_return(mock_order(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(order_url(mock_order))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested order" do
        Order.should_receive(:find).with("37").and_return(mock_order)
        mock_order.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :order => {:these => 'params'}
      end

      it "should expose the order as @order" do
        Order.stub!(:find).and_return(mock_order(:update_attributes => false))
        put :update, :id => "1"
        assigns(:order).should equal(mock_order)
      end

      it "should re-render the 'edit' template" do
        Order.stub!(:find).and_return(mock_order(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested order" do
      Order.should_receive(:find).with("37").and_return(mock_order)
      mock_order.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the orders list" do
      Order.stub!(:find).and_return(mock_order(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(orders_url)
    end

  end

end
