class UserRecommendation < ActiveRecord::Base
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :target, :class_name => "User", :foreign_key => "target_id"
  belongs_to :product, :class_name => "Product", :foreign_key => "product_id"  
  validates_presence_of :sender_id, :message => "can't be blank"
  validates_presence_of :target_id, :message => "can't be blank"
  validates_presence_of :product_id, :message => "can't be blank"
  validate :must_be_unique, :message => "must be unique"
  validate :must_be_friends
  validate :must_not_be_friends
  validate :reject_self_recommendation    
  validate :must_have_five_recommendations_at_most
  validate :must_not_be_sent_to_user_who_has_already_rated_the_product  

  def must_be_friends
    if sender.stage_number == 3 
      errors.add_to_base("Deve ser enviada a um amigo") unless sender.friends.include?(target)
    end
  end 

  def must_have_five_recommendations_at_most
    if sender.stage_number == 3 
      errors.add_to_base("Já foi enviada 5 vezes para este amigo.") if sender.recommendations_count_to(target) >= 5
    end
  end

  def must_not_be_friends
    if sender && sender.stage_number == 4 
      errors.add_to_base("Deve ser enviada a um desconhecido") if sender.friends.include?(target)
    end
  end                                

  def reject_self_recommendation
    errors.add_to_base("Não pode ser enviada a si mesmo") if sender_id.eql?(target_id)
  end  

  def must_not_be_sent_to_user_who_has_already_rated_the_product
    errors.add_to_base("Não pode ser enviada a um pessoa que já avaliou o produto.") if target.rated?(product)
  end
  
  def must_be_unique  
    errors.add_to_base("Este produto já foi recomendado para esta pessoa.") if UserRecommendation.first(:conditions => {:sender_id => sender_id, :target_id => target_id, :product_id => product_id})
  end     


end
