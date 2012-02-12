require 'spec_helper'

describe BricksController do

  def mock_brick(stubs={})
    @mock_brick ||= mock_model(Brick, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all bricks as @bricks" do
      Brick.should_receive(:find).with(:all, {
        :order=>"purchased_at DESC", 
        :offset=>0, 
        :limit=>30, 
        :conditions=>[
          "purchased_at IS NOT NULL and naughty=:naughty", 
          {:naughty=>false}
        ]
      }).and_return([mock_brick])
      get :index
      assigns[:bricks].should == [mock_brick]
    end

    describe "with mime type of xml" do
  
      it "should render all bricks as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Brick.should_receive(:paginate).with(
          :page=>nil,
          :order=>"purchased_at DESC", 
          :conditions=>[
            "purchased_at IS NOT NULL and naughty=:naughty", 
            {:naughty=>false}
          ]
        ).and_return(bricks = mock("Array of Bricks"))
        bricks.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested brick as @brick" do
      Brick.should_receive('find_by_url_key!').with("37").and_return(mock_brick(:naughty? => false))
      get :show, :id => "37"
      assigns[:brick].should equal(mock_brick)
    end
    
    describe "with mime type of xml" do

      it "should render the requested brick as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Brick.should_receive('find_by_url_key!').with("37").and_return(mock_brick(:naughty? => false))
        mock_brick.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end                                   

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new brick as @brick" do
      Brick.should_receive(:new).and_return(mock_brick)
      get :new
      assigns[:brick].should equal(mock_brick)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested brick as @brick" # do
    #       Brick.should_receive('find_by_url_key!').with("37").and_return(mock_brick)
    #       get :edit, :id => "37"
    #       assigns[:brick].should equal(mock_brick)
    #     end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created brick as @brick" do
        Brick.should_receive(:new).with({'these' => 'params'}).and_return(mock_brick(:save => true))
        post :create, :brick => {:these => 'params'}
        assigns(:brick).should equal(mock_brick)
      end

      it "should redirect to the created brick" # do
       #        Brick.stub!(:new).and_return(mock_brick(:save => true, :url_key => 'foo'))
       #        post :create, :brick => {}
       #        response.should redirect_to(confirm_bricks_url(mock_brick))
       #      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved brick as @brick" do
        Brick.stub!(:new).with({'these' => 'params'}).and_return(mock_brick(:save => false))
        post :create, :brick => {:these => 'params'}
        assigns(:brick).should equal(mock_brick)
      end

      it "should re-render the 'new' template" do
        Brick.stub!(:new).and_return(mock_brick(:save => false))
        post :create, :brick => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested brick" do
        Brick.should_receive('find_by_url_key!').with("37").and_return(mock_brick)
        mock_brick.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :brick => {:these => 'params'}
      end

      it "should expose the requested brick as @brick" do
        Brick.stub!(:find).and_return(mock_brick(:update_attributes => true))
        put :update, :id => "1"
        assigns(:brick).should equal(mock_brick)
      end

      it "should redirect to the brick" do
        Brick.stub!(:find).and_return(mock_brick(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(brick_url(mock_brick))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested brick" do
        Brick.should_receive('find_by_url_key!').with("37").and_return(mock_brick)
        mock_brick.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :brick => {:these => 'params'}
      end

      it "should expose the brick as @brick" do
        Brick.stub!(:find).and_return(mock_brick(:update_attributes => false))
        put :update, :id => "1"
        assigns(:brick).should equal(mock_brick)
      end

      it "should re-render the 'edit' template" do
        Brick.stub!(:find).and_return(mock_brick(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested brick" # do
     #      Brick.should_receive('find_by_url_key!').with("37").and_return(mock_brick)
     #      mock_brick.should_receive(:destroy)
     #      delete :destroy, :id => "37"
     #    end                                  
  
    it "should redirect to the bricks list" do
      Brick.stub!(:find).and_return(mock_brick(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(root_url)
    end

  end

end
