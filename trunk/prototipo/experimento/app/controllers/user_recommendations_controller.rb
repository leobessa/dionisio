class UserRecommendationsController < ApplicationController  

  before_filter :authenticate_user!      

  def new
    @target = User.find(params[:user_id])
    @user_recommendation = UserRecommendation.new 
    @search = Product.with_ratings_from(@target).search(params[:search]) 
    if params[:search] && params[:search].reject{ |key,value| key == 'order' }.values.any? { |param| not param.empty?  }
      @products = @search.paginate(:per_page => 5, :page => params[:page]) 
    end                                                              
  end

  def create                     
    @target =  User.find(params[:user_id])
    @user_recommendation = UserRecommendation.new(params[:user_recommendation]) 
    @user_recommendation.target = @target
    @user_recommendation.sender = current_user
    if @user_recommendation.save 
      x = current_user.recommendations_count_to(@target)  
      y = case current_user.stage_number
        when 3
          5
        when 4
          RecommendationGuide.first(:conditions => {:sender_id => current_user, :target_id => @target}).times
        end                        
      if x < y
        message = "Restam apenas #{y-x} recomendações para #{@target.name}" if (y-x) > 1
        message = "Resta apenas 1 recomendação para #{@target.name}" if (y-x) == 1 
        flash[:notice] = "Recomendação enviada com sucesso. #{message}" 
        redirect_to new_user_user_recommendation_path(@target)
      else 
        flash[:notice] = "Recomendação enviada com sucesso."           
        redirect_to root_path                                                            
      end      
    else 
      flash[:error] = @user_recommendation.errors.full_messages.join
      redirect_to root_path
    end
  end 

end
