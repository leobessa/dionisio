class UserRecommendationsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @product = Product.with_ratings_from(current_user).find(params[:product_id])
    @user_recommendation = UserRecommendation.new(params[:user_recommendation]) 
    @user_recommendation.product_id = params[:product_id]
    @friends = current_user.friends
  end

  def create                     
    @user_recommendation = UserRecommendation.new(params[:user_recommendation]) 
    @user_recommendation.sender = current_user
    if @user_recommendation.save 
      flash[:notice] = "Recomendação enviada com sucesso." 
      redirect_to root_path                                                            
    else 
      flash[:error] = @user_recommendation.errors.full_messages.join
      @product = Product.with_ratings_from(current_user).find(params[:product_id])
      render :new
    end
  end

end
