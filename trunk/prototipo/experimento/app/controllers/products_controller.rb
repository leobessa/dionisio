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
      if params[:unknown]
        @rating.update_attributes :stars => params[:stars], :unknown => params[:unknown]
      else
        @rating.update_attribute :stars, params[:stars]
      end
    else
      @rating = Rating.create :product => @product, :stars => params[:stars], :user => current_user, :unknown => params[:unknown]
    end
    respond_to do |format|
      format.js do
        id = "star-rating-for-product-#{@product.id}"
        puts @rating.inspect
        render :update do |page| 
          page.replace_html 'phase-description', phase_description_content                       
          page.replace_html id, :partial => 'shared/star_rating', :locals => {:rating => @rating, :product => @product}
          page.show "#{@product.id}-checkbox"
          page << "$('nc-#{@product.id}').setValue(#{@rating.unknown});"
          page.redirect_to(root_path) if current_user.completed_stage?
        end                                                           
      end
      format.html { redirect_to(products_path)}
    end

  end  

  def index
    @search = Product.search(params[:search])
    @products = @search.paginate(:page => params[:page]) 
    @ratings = Rating.find(:all,:conditions => {:user_id => current_user,:product_id => @products})
  end 

  def show
    @product = Product.find(params[:id])
    @rating  = Rating.find(:first,:conditions => {:user_id => current_user,:product_id => @product}) || Rating.new(:stars => 0)
    @show_stars = true
    @truncate_description = false                                             
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
