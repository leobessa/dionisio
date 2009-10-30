class UserRecommendation < ActiveRecord::Base
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :target, :class_name => "User", :foreign_key => "target_id"
  belongs_to :product, :class_name => "Product", :foreign_key => "product_id"
  validates_presence_of :sender_id
  validates_presence_of :target_id
  validates_presence_of :product_id
  validates_uniqueness_of :target_id, :scope => [:sender_id,:product_id], :message => "must be unique"
  validate :must_be_friends, :if => [:sender,:target]
  validate :must_not_be_friends
  validate :reject_self_recommendation

  def must_be_friends
    if sender.stage_number == 3 
      errors.add_to_base("Deve ser enviada a um amigo") unless sender.friends.include?(target)
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
  
  
end
