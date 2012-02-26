# encoding: UTF-8
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotification::Notifiable
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password
  
  helper_method :admin?
  
  protected
  
  def current_brick
    if session[:brick_id]
      @current_brick ||= Brick.find(session[:brick_id])
      session[:brick_id] = nil if @current_brick.purchased_at
    end
    @current_brick
  end
  
  def authorize
    unless admin?
      flash[:notice] = "Unauthorized Access"
      redirect_to root_path
      false
    end
  end
  
  def admin?
    (session[:user] == ADMIN_USERNAME and session[:password] == ADMIN_PASSWORD)
  end
end
