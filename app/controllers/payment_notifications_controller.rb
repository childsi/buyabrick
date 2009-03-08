class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:success]
  before_filter :authorize, :only => [:create]
  
  def create
    @notification = PaymentNotification.create(params[:payment_notification])
    redirect_to root_path
  end
  
  def success
    protx_params = GATEWAY.parse_response(CGI.escape(params[:crypt]))
    PaymentNotification.create!(protx_params)
    redirect_to root_path
  end
end
