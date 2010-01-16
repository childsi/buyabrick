class ReportsController < ApplicationController
  before_filter :authorize
  
  def index
  end
  
  def bricks
    response.headers['Cache-Control'] = 'public, max-age=30'
    @bricks = Brick.all(
      :order => 'purchased_at', 
      :conditions => ["purchased_at IS NOT NULL"]
    )
    
    respond_to do |format|
      format.html { render :layout => false }
      format.csv { send_data @bricks.to_csv }
    end
  end
  
  def generous_bricks
    @bricks = Brick.paginate(
      :page => params['page'],
      :order => 'purchased_at', 
      :conditions => ["purchased_at IS NOT NULL AND value >= 10000"]
    )
  end
end
