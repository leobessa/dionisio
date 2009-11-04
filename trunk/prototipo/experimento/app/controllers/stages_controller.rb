class StagesController < ApplicationController  
  before_filter :authenticate_admin!                           
  
  def index
    @stages = Stage.all
  end
  
  def show
    @stage = Stage.find(params[:id])
  end
  
  def create
    @stage = Stage.new(params[:stage])
    if @stage.save
      flash[:notice] = "Successfully created stage."
      redirect_to @stage
    else
      render :action => 'new'
    end
  end
  
  def edit
    @stage = Stage.find(params[:id])
  end
  
  def update
    @stage = Stage.find(params[:id])
    if @stage.update_attributes(params[:stage])
      flash[:notice] = "Successfully updated stage."
      redirect_to @stage
    else
      render :action => 'edit'
    end
  end
  
end
