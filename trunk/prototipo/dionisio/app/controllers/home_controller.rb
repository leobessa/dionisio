class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    if (current_user.is_cold?)
      render :template => 'home/cold-start', :locals => {:products => Product.selected.with_ratings_from(current_user).paginate(:page => params[:page]) }
    else
      redirect_to :controller => 'recommendations', :action => 'profile'
    end
    
  end
end
