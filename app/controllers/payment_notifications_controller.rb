class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:success, :failed]
  before_filter :authorize, :only => [:create]
  
  def create
    @notification = PaymentNotification.create(params[:payment_notification])
    redirect_to root_path
  end
  
  def success
    if params[:crypt]
      protx_params = GATEWAY.parse_response(CGI.escape(params[:crypt]))
      @notification = PaymentNotification.create!(protx_params)
      redirect_to brick_path(@notification.brick)
    else
      redirect_to root_path
    end
  end
  
  def failed
    if params[:crypt]
      protx_params = GATEWAY.parse_response(CGI.escape(params[:crypt]))
      @notification = PaymentNotification.create!(protx_params)
    else
      redirect_to root_path
    end
  end
end
