class HomeController < ApplicationController        

  def index                     
    if user_signed_in?
      case current_user.stage.number
        when 1 then show_selected_products_to_user 
      end
    end       
  end       

  def show_selected_products_to_user
    products = Product.all :conditions => {:selected => true}
    render :partial => "stage1", :locals => { :products => products }, :layout => 'application'
  end

end
