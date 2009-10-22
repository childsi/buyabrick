class BricksController < ApplicationController
  before_filter :authorize, :only => [:edit, :destroy, :naughties]
  
  # GET /bricks
  # GET /bricks.xml
  def index
    response.headers['Cache-Control'] = 'public, max-age=30'
    
    @bricks = Brick.paginate(
      :page => params[:page], 
      :order => 'purchased_at DESC', 
      :conditions => ["purchased_at IS NOT NULL and naughty=:naughty", { :naughty => false }])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bricks }
      format.rss  { render :layout => false }
    end
  end
  
  def naughties
    @bricks = Brick.paginate(
      :page => params[:page], 
      :order => 'purchased_at DESC', 
      :conditions => ["naughty=:naughty", { :naughty => true }])
  end

  # GET /bricks/1
  # GET /bricks/1.xml
  def show
    @brick = Brick.find_by_url_key!(params[:id])
    raise ActiveRecord::RecordNotFound if (@brick.naughty? and !admin?)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @brick }
    end
  end
  
  # GET /bricks/new
  # GET /bricks/new.xml
  def new
    @brick = Brick.new(
      :colour => Brick.random_colour,
      :value_in_pounds => params[:value]
    )
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @brick }
    end
  end

  # GET /bricks/1/edit
  def edit
    @brick = Brick.find_by_url_key!(params[:id])
  end

  # POST /bricks
  def create
    @brick = Brick.new(params[:brick])
    if @brick.save
      session[:brick_id] = @brick.id
      redirect_to confirm_bricks_path
    else
      render :action => "new"
    end
  end
  
  def confirm
    @brick = current_brick
    @payment_notification = PaymentNotification.new(:status => 'OK', :brick => @brick) if admin?
    return redirect_to(root_path) if current_brick.nil?
  end
  
  def thanks
    @brick = Brick.find_by_url_key!(params[:id])
  end
  
  # PUT /bricks/1
  # PUT /bricks/1.xml
  def update
    @brick = Brick.find_by_url_key!(params[:id])
    
    respond_to do |format|
      if @brick.update_attributes(params[:brick])
        flash[:notice] = 'Brick was successfully updated.'
        format.html { redirect_to(@brick) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @brick.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bricks/1
  # DELETE /bricks/1.xml
  # def destroy
  #   @brick = Brick.find_by_url_key!(params[:id])
  #   @brick.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(bricks_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
