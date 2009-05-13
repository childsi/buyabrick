class WallController < ApplicationController
  def show
    @bricks = Brick.paginate(
      :select => 'url_key,first_name,last_name,colour,icon_id,url,twitter,value,show_value,naughty',
      :per_page => 1000,
      :page => params[:page], 
      :order => 'purchased_at DESC', 
      :conditions => ["purchased_at IS NOT NULL and naughty=:naughty", { :naughty => false }])
    @wall = {
      :details => {
        :total_pages => @bricks.total_pages,
        :total_bricks => @bricks.total_entries,
      },
      :bricks => @bricks
    }
    
    respond_to do |format|
      format.xml  { render :xml => @wall }
      format.json  { render :json => @wall }
    end
  end
end
