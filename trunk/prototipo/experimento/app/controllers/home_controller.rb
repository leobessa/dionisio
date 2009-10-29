class HomeController < ApplicationController  
  before_filter :authenticate_user!      

  def index                     
    case current_user.stage_number
    when 1 then show_selected_products_to_user 
    when 2 then show_products_search
    end                                             
  end       

  private
  def show_selected_products_to_user
    products = Product.selected
    render :partial => "stage1", :locals => { :products => products }, :layout => 'application'
  end

  def show_products_search 
    redirect_to :action => 'index', :controller => 'products'
  end

end
