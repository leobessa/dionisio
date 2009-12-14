class RatingsController < ApplicationController
  before_filter :authenticate_user!             
  
  def index
    @user = User.find(params[:user_id])
    @ratings = Rating.all(:joins => :product, :conditions => {:user_id => @user},:order => 'stars DESC')
  end
end
