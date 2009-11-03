class ProductsController < ApplicationController    
  
  before_filter :authenticate_user! 
  
  def unknown
    @product = Product.find(params[:id])
    rating = Rating.find(:first,:conditions => {:product_id => @product,:user_id => current_user})
    if rating
      rating.update_attribute :unknown, params[:unknown]
      render :text => "ok!"
    else
      render :text => "Faça primeiro a avaliação do produto"
    end
  end            
  
  def rate
    @product = Product.find(params[:id])
    rating = Rating.find(:first,:conditions => {:product_id => @product,:user_id => current_user})
    if rating
      rating.update_attribute :stars, params[:stars]
    else
      Rating.create :product => @product, :stars => params[:stars], :user => current_user
    end
    respond_to do |format|
      format.js do
        id = "star-rating-for-product-#{@product.id}"
        render :update do |page|
          page.replace_html id, :partial => 'shared/star_rating', :locals => {:product => @product, :user => current_user}
          page.visual_effect :highlight, id 
          page.replace_html 'phase-description', phase_description_content                       
          page.redirect_to(root_path) if current_user.completed_stage?
        end                                                           
      end
      format.html { redirect_to(products_path)}
    end
        
  end
  
  def index
    @search = Product.search(params[:search])
    @products = @search.all.paginate(:page => params[:page])
  end 
  
  def show
    @product = Product.find(params[:id])                                              
  end

end
