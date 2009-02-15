class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:success]
  
  def success
    protx_params = GATEWAY.parse_response(CGI.escape(params[:crypt]))
    PaymentNotification.create!(protx_params)
    redirect_to root_path
  end
end
