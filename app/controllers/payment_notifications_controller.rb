class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:success]
  
  def success
    protx_params = GATEWAY.decrypt_from_protx(params[:crypt])
    p protx_params
    brick_id = $1 if protx_params['VendorTxCode'] =~ /bricks-(\d+)/
    PaymentNotification.create!(
      :params => protx_params, 
      :status => protx_params['Status'],
      :transaction_id => protx_params['TxAuthNo'],
      :brick_id => brick_id
    )
    redirect_to root_path
  end
end
