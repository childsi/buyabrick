class WallController < ApplicationController
  def show
    @bricks = Brick.paginate(
      :select => 'url_key,first_name,last_name,message,colour,icon_id,url,twitter,value,show_value,naughty',
      :per_page => 1000,
      :page => params[:page], 
      :order => 'purchased_at', 
      :conditions => ["purchased_at IS NOT NULL and naughty=:naughty", { :naughty => false }])
    @wall = {
      :details => {
        :total_pages => @bricks.total_pages,
        :total_bricks => @bricks.total_entries,
        :total_money => Wall.total_amount,
        :total_messages => Wall.total_messages,
        :date => Date.today,
      },
      :bricks => @bricks
    }
    
    respond_to do |format|
      format.xml  { render :xml => @wall }
      format.json  { render :json => @wall }
    end
  end
end
