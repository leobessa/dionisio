class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      redirect_to new_user_session_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find params[:id]
  end

  def index
    @users = User.all
  end
  
end
