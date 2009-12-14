class RecommendationsController < ApplicationController
  before_filter :authenticate_user!

  def profile
    recommendations_for 'profile'
    @recommendation_algorithm = 'pelo Algoritmo Baseado em Similaridade de Perfil'
    render 'index'
  end

  def item
    recommendations_for 'item'
    @recommendation_algorithm = 'pelo Algoritmo Baseado em Similaridade de Item'
    render 'index'
  end

  def trust
    recommendations_for 'trust'
    @recommendation_algorithm = 'pelo Algoritmo Baseado em Confiança'
    render 'index'
  end

  def from_users
    # @recommendations = current_user.user_recommendations(:order => 'created_at DESC',:include => :products)
    @products = Product.with_ratings_from(current_user).find(:all, :joins => :user_recommendations, 
    :conditions => "'user_recommendations'.target_id = #{current_user.id}", :order => "'user_recommendations'.created_at DESC")
    @recommendation_algorithm = 'enviadas por outros usuários'
    render :index
  end

  private
  def recommendations_for(type)
    mod = "Recommender::#{type.capitalize}Based".constantize
    ids = mod.recommendations_for(current_user).map {|r| r[:product_id]}
    @products = Product.with_ratings_from(current_user).find(ids)
  end

end
