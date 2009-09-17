class UserRecommendationsController < ApplicationController 
  
  def create
    @user_recommendation = UserRecommendation.new params[:user_recommendation]
    @user_recommendation.recommender = current_user
    
    respond_to do |format|
      if @user_recommendation.save
        flash[:notice] = 'Recommendation was successfully created.'
        format.html { redirect_to(@user_recommendation) }
        format.xml  { render :xml => @user_recommendation, :status => :created, :location => @user_recommendation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_recommendation.errors, :status => :unprocessable_entity }
      end
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
