class UsersController < ApplicationController
  
  def new
    @user = User.new(:invitation_token => params[:invitation_token])
    @user.email = @user.invitation.recipient_email if @user.invitation
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Seu cadastro foi realizado com sucesso."
      redirect_to new_user_session_path
    else
      render :action => 'new'
    end
  end 
  
  def show
    @user = User.find(params[:id])
  end

end
