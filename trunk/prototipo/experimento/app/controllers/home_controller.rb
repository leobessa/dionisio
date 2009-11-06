class HomeController < ApplicationController  
  before_filter :authenticate_user!      
  before_filter :check_stage_avaiability

  def index                     
    case current_user.stage_number
    when 1 then show_selected_products_to_user 
    when 2 then show_products_search 
    when 3 then show_friends
    end                                             
  end       

  private                         
  def check_stage_avaiability
    if Stage.find_by_number(current_user.stage_number).enabled?
      return true
    else
      render :partial => "unavaiable_stage", :layout => 'application'
      return false
    end
  end
    
  def show_selected_products_to_user 
    @products = Product.selected.with_ratings_from(current_user).all
    render :partial => "stage1", :locals => { :products => @products }, :layout => 'application'
  end

  def show_products_search 
    redirect_to :action => 'index', :controller => 'products'
  end  
  
  def show_friends
    @users = current_user.friends
    render :partial => 'make_recommendations', :locals => {:users => @users}, :layout => 'application'
  end

end
