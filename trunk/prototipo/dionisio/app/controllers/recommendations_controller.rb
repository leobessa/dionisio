class RecommendationsController < ApplicationController
  before_filter :authenticate_user!
  
  def profile
    recommendations_for 'profile'
    @recommendation_algorithm = 'Similaridade de Perfil'
    render 'index'
  end

  # def item
  #   recommendations_for 'item'
  #   @recommendation_algorithm = 'Similaridade de Item'
  #   render 'index'
  # end

  def trust
    recommendations_for 'trust'
    @recommendation_algorithm = 'Confiança'
    render 'index'
  end
  
  private
  def recommendations_for(type)
    mod = "Recommender::#{type.capitalize}Based".constantize
    @products = Product.find(mod.recommendations_for(current_user).map{|h|h[:product_id]}).map do |p|
      def p.rating; 0; end;
      p
    end
  end

end
