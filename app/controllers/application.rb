# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e44096df58704c989de45a316fc97dae'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  helper_method :admin?
  
  filter_parameter_logging :password
  
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
    (session[:user] == 'foo' and session[:password] == 'bar')
  end
end
