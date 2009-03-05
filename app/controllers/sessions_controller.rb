class SessionsController < ApplicationController
  def new
  end
  
  def create
    session[:user] = params[:user]
    session[:password] = params[:password]
    flash[:notice] = 'Successfully logged in'
    redirect_to root_path
  end
  
  def destroy
    reset_session
    flash[:notice] = 'Successfully logged out'
    redirect_to root_path
  end
end
