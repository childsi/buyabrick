class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:success, :failed]
  before_filter :authorize, :only => [:create]
  
  def create
    @notification = PaymentNotification.create(params[:payment_notification])
    redirect_to root_path
  end
  
  def return
    if params[:donationId]
      @brick = Brick.find_by_url_key!(params[:id])
      # save the donation id in case you need to further probe any details
      donation_id = params[:donationId]
      @brick.update_attribute(:donation_id, donation_id)
      @donation = JustGiving::Donation.new(params[:donationId])
      @notification = PaymentNotification.create_by_brick_and_justgiving(@brick, @donation.details)
      # TODO what if the payment failed or was cancelled?
      if @donation.details['status'] == 'Accepted' or @donation.details['status'] == 'Pending'
        redirect_to thanks_brick_path(@notification.brick)
      else 
        redirect_to failed_payment_notifications(@notification)
      end
    else
      redirect_to root_path
    end
  end
  
  # def success
  #   if params[:crypt]
  #     protx_params = GATEWAY.parse_response(params[:crypt])
  #     @notification = PaymentNotification.create!(protx_params)
  #     raise if @notification.status =~ /\n/
  #     redirect_to thanks_brick_path(@notification.brick)
  #   else
  #     redirect_to root_path
  #   end
  # end
  
  def failed
    if params[:notification]
      @notification = PaymentNotification.find(params[:id])
    else
      redirect_to root_path
    end
  end
end
