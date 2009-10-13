class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to (session[:restricted_url_to_access] || @user_session.user)
    else
      flash[:notice] = t(:login_failed)
      render :action => 'new'
    end
    session[:restricted_url_to_access] = nil
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy if @user_session
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end
