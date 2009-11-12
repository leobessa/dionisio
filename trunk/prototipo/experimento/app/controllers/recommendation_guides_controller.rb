class RecommendationGuidesController < ApplicationController
  def index
    @recommendation_guides = RecommendationGuide.all
  end
  
  def show
    @recommendation_guide = RecommendationGuide.find(params[:id])
  end
  
  def new
    @recommendation_guide = RecommendationGuide.new :times => 1
  end
  
  def create
    @recommendation_guide = RecommendationGuide.new(params[:recommendation_guide])
    if @recommendation_guide.save
      flash[:notice] = "Successfully created recommendation guide."
      redirect_to @recommendation_guide
    else
      render :action => 'new'
    end
  end
  
  def edit
    @recommendation_guide = RecommendationGuide.find(params[:id])
  end
  
  def update
    @recommendation_guide = RecommendationGuide.find(params[:id])
    if @recommendation_guide.update_attributes(params[:recommendation_guide])
      flash[:notice] = "Successfully updated recommendation guide."
      redirect_to @recommendation_guide
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @recommendation_guide = RecommendationGuide.find(params[:id])
    @recommendation_guide.destroy
    flash[:notice] = "Successfully destroyed recommendation guide."
    redirect_to recommendation_guides_url
  end
end
