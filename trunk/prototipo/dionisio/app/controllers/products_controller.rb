class ProductsController < ApplicationController    

  before_filter :authenticate_user! 

  def rate
    params[:rating][:user_id] = current_user.id
    @rating = Rating.find(:first,:conditions => {:user_id => params[:rating][:user_id], :product_id => params[:rating][:product_id] })
    if @rating
      @rating.update_attributes params[:rating]
    else
      @rating = Rating.create params[:rating]
    end
    respond_to do |format|
      format.js do
        id = "star-rating-for-product-#{@rating.product_id}"
        render :update do |page| 
          page.replace_html id, :partial => 'product/star_rating', :locals => {:stars => @rating.stars, :product_id => @rating.product_id}
        end                                                           
      end
      format.html { redirect_to(:back)}
    end

  end  

  def index
    @search = Product.with_ratings_from(current_user).search(:name_like => params[:query]) 
    @products = @search.paginate(:page => params[:page]) 
  end 

  def show
    @product = Product.with_ratings_from(current_user).find(params[:id])                                           
  end  


end
