class ProductsController < ApplicationController    

  before_filter :authenticate_user! 
  around_filter :add_products_scope

  def unknown
    @rating = Rating.find(:first,:conditions => {:user_id => current_user.id, :product_id => params[:id]})
    @rating.unknown = params[:rating][:unknown]
    if @rating.save 
      respond_to do |format| 
        format.js do
          render :update do |page|    
            page.replace_html 'phase-description', phase_description_status
            page.visual_effect :highlight,  "radio-button-for-product-#{@rating.product_id}"
            page.redirect_to(root_path) if current_user.completed_stage?
          end         
        end
        format.html { redirect_to :back }          
      end
    else
      respond_to do |format| 
        format.js do
          render :update do |page|    
            "alert('Occoreu um problema. Tente novamente.')"
          end         
        end
        format.html { redirect_to :back }          
      end 
    end
  end            

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
          page.replace_html 'phase-description', phase_description_status                       
          page.replace_html id, :partial => 'shared/star_rating', :locals => {:stars => @rating.stars, :product_id => @rating.product_id}
          page.show "radio-button-for-product-#{@rating.product_id}"
          page.redirect_to(root_path) if current_user.completed_stage?
        end                                                           
      end
      format.html { redirect_to(:back)}
    end

  end  

  def index
    @search = Product.with_ratings_from(current_user).search(params[:search]) 
    if params[:search] && params[:search].reject{ |key,value| key == 'order' }.values.any? { |param| not param.empty?  }
      @products = @search.paginate(:page => params[:page]) 
    end
  end 

  def show
    @product = Product.with_ratings_from(current_user).find(params[:id])
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
