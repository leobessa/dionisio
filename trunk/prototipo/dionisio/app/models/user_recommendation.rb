class UserRecommendation < ActiveRecord::Base
  attr_accessible :sender_id, :target_id, :product_id
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :target, :class_name => "User", :foreign_key => "target_id"
  belongs_to :product
  
  validates_presence_of :sender_id
  validates_presence_of :target_id
  validates_presence_of :product_id
  validate :must_be_unique
  validate :reject_self_recommendation    
  validate :must_not_be_sent_to_user_who_has_already_rated_the_product  

  def reject_self_recommendation
    errors.add_to_base("Não pode ser enviada a si mesmo") if sender_id.eql?(target_id)
  end  

  def must_not_be_sent_to_user_who_has_already_rated_the_product
    errors.add_to_base("Recomendação não pode ser enviada a uma pessoa que já avaliou o produto.") if target.rated?(product)
  end
  
  def must_be_unique  
    errors.add_to_base("Esta recomendação foi enviada com sucesso.") if UserRecommendation.first(:conditions => {:sender_id => sender_id, :target_id => target_id, :product_id => product_id})
  end     
  
end
