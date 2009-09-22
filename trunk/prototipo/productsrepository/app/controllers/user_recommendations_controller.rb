class UserRecommendationsController < ApplicationController 
  
  def create    
    target_users = params[:targert_users]  
    if (target_users.nil? || target_users.empty?)
      flash[:error] = "Recommendations must have a target user"  
      redirect_to new_product_user_recommendation_path(params[:user_recommendation][:product_id])
    else
       target_users.each do |target|  
          @user_recommendation = UserRecommendation.new params[:user_recommendation]
          @user_recommendation.recommender = current_user
          @user_recommendation.target_user_id = target 
          @user_recommendation.save
        end
        flash[:notice] = "Recommendation was successfully send."
        redirect_to @user_recommendation.product
    end 
  end                                                                   
  
  def new
    @user_recommendation = UserRecommendation.new
    @user_recommendation.recommender = current_user  
    @product = Product.find(params[:product_id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_recommendation }
    end
  end
  
end
