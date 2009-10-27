class ProductsController < ApplicationController                 
  
  def rate
    @product = Product.find(params[:id])
    @product.rate(params[:stars], current_user, params[:dimension])
    id = "ajaxful-rating-product-#{@product.id}"
    render :update do |page|
      page.replace_html id, ratings_for(@product, :wrap => false, :dimension => params[:dimension])
      page.visual_effect :highlight, id 
      page.replace_html 'phase-description', phase_description_content                       
      if current_user.completed_stage?
        current_user.advance_stage
        page.redirect_to(root_path)
      end
    end
  end
  
  def index
    @search = Product.search(params[:search])
    @products = @search.all
  end                                               

end
