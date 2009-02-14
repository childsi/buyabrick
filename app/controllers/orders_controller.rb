class OrdersController < ApplicationController
  
  # def redirect
  #   return redirect_to root_path if current_brick.nil?
  #   
  #   order = current_brick.prepare_order(params[:order])
  #   response = EXPRESS_GATEWAY.setup_purchase(order.value_in_pence,
  #     :ip => request.remote_ip,
  #   )
  #   redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  # end
  
  # GET /orders/new
  def new
    @brick = current_brick
    return redirect_to root_path if current_brick.nil?
    @order = Order.new
  end

  # POST /orders
  # POST /orders.xml
  def create
    @brick = current_brick
    return redirect_to root_path if current_brick.nil?
    
    @order = @brick.prepare_order(params[:order])
    @order.ip_address = request.remote_ip
    
    if @order.save
      if @order.purchase
        session[:brick_id] = nil
        render :action => :success
      else
        render :action => :failure
      end
    else
      render :action => "new"
    end
  end
end
