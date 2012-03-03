class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:success, :failed]
  before_filter :authorize, :only => [:create]
  
  def create
    @notification = PaymentNotification.create(params[:payment_notification])
    redirect_to root_path
  end
  
  def return
    unless params[:donationId].blank?
      @brick = Brick.find_by_url_key!(params[:id])
      @donation = JustGiving::Donation.new(params[:donationId])
      @notification = PaymentNotification.create_by_brick_and_justgiving(@brick, @donation.details)
      if @notification.status == 'OK'
        redirect_to thanks_brick_path(@notification.brick)
      else
        redirect_to failed_payment_notification_path(@notification)
      end
    else
      redirect_to root_path
    end
  end
  
  def failed
    @notification = PaymentNotification.find(params[:id])
  end
end
