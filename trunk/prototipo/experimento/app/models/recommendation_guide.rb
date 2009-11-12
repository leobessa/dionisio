class RecommendationGuide < ActiveRecord::Base
  attr_accessible :sender_id, :target_id, :times
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :target, :class_name => "User", :foreign_key => "target_id"
  validates_numericality_of :times                                
  validates_presence_of :sender, :target
  validates_uniqueness_of :times, :scope => [:target_id,:sender_id]
  
  validate :cant_from_the_same_group
  
  def cant_from_the_same_group
    errors.add_to_base("Estes não podem pertencer ao mesmo grupo.") if sender.group.users.include?(target)
  end
end
