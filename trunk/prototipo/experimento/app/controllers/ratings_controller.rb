class RatingsController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @ratings = Rating.all
  end                    

end
