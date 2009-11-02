class UserRecommendationsController < ApplicationController  
                                              
  before_filter :authenticate_user!      
  
  def new
    @target = User.find(params[:user_id])
    @user_recommendation = UserRecommendation.new 
    @search = Product.search(params[:search])
    @products = @search.all.paginate(:page => params[:page])
  end
  
  def create                     
    @target =  User.find(params[:user_id])
    @user_recommendation = UserRecommendation.new(params[:user_recommendation]) 
    @user_recommendation.target = @target
    @user_recommendation.sender = current_user
    if @user_recommendation.save
      flash[:notice] = "Recomendação enviada com sucesso."
      redirect_to root_url
    else
      @search = Product.search(params[:search])
      @products = @search.all
      render :action => 'new'
    end
  end
end
