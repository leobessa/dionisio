class AdminController < ApplicationController

  before_filter :authenticate_admin!                           
  
  def index
    @users = User.find(:all, :order => :updated_at)
  end

end
