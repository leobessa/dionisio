class ProductController < ApplicationController                 
  
  def rate
    @product = Product.find(params[:id])
    @product.rate(params[:stars], current_user, params[:dimension])
    id = "ajaxful-rating-product-#{@product.id}"
    render :update do |page|
      page.replace_html id, ratings_for(@product, :wrap => false, :dimension => params[:dimension])
      page.visual_effect :highlight, id 
      page.redirect_to(root_path) if current_user.completed_stage?
    end
  end

end
