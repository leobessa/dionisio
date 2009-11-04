class ProductsController < ApplicationController    

  before_filter :authenticate_user! 
  around_filter :add_products_scope

  def unknown
    @product = Product.find(params[:id])
    rating = Rating.find(:first,:conditions => {:product_id => @product,:user_id => current_user})
    if rating
      rating.update_attribute :unknown, params[:unknown]
      render :update do |page|
        page.replace_html "nc-#{@product.id}-message", ""
        page.visual_effect :highlight,"#{@product.id}-checkbox"
      end
    else
      render :update do |page|
        id = "nc-#{@product.id}-message"
        page.replace_html id, "Faça primeiro a avaliação do produto" 
        page.visual_effect :highlight, id 
      end 
    end
  end            

  def rate
    @product = Product.find(params[:id])
    @rating = Rating.find(:first,:conditions => {:product_id => @product,:user_id => current_user})
    if @rating
      @rating.update_attribute :stars, params[:stars]
    else
      @rating = Rating.create :product => @product, :stars => params[:stars], :user => current_user
    end
    @rating.update_attribute :unknown, params[:unknown]
    respond_to do |format|
      format.js do
        id = "star-rating-for-product-#{@product.id}"
        render :update do |page|
          page.replace_html id, :partial => 'shared/star_rating', :locals => {:product => @product, :user => current_user}
          page.visual_effect :highlight, id                           
          page << "$('#{@product.id}-checkbox').style.visibility = 'visible';"
          page << "$('nc-#{@product.id}').checked = #{@rating.unknown};"
          page.visual_effect :highlight, "#{@product.id}-checkbox"
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

  private
  def add_products_scope
    if current_user.stage_number == 1
      Product.send(:with_scope,:find => {:conditions => {:selected => true}}) do
        yield                                                                     
      end
    else
      yield
    end
  end

end
