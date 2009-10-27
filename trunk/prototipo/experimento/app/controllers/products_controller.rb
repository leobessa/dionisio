class ProductsController < ApplicationController                 
  
  def rate
    @product = Product.find(params[:id])
    @product.rate(params[:stars], current_user, params[:dimension])
    id = "ajaxful-rating-product-#{@product.id}"
    render :update do |page|
      page.replace_html id, ratings_for(@product, :wrap => false, :dimension => params[:dimension])
      page.visual_effect :highlight, id 
      page.replace_html 'phase-description', phase_description_content                       
      puts "rate count = #{Rate.count(:conditions => {:user_id => current_user, :rateable_id => Product.selected.map(&:id)})}"
      puts "selected count = #{Product.selected.count}"
      if current_user.completed_stage?
        puts "---------------------------------"
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
