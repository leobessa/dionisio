class RecommendationsController < ApplicationController  
  
  before_filter :get_user

  def get_user
    @user = User.find(params[:user_id])
  end
  
  def index
    @recommendations = @user.recommended_products
  end

end
