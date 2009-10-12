class UserRecommendation < ActiveRecord::Base
  belongs_to :recommender, :class_name => "User", :foreign_key => "recommender_id" 
  belongs_to :target_user, :class_name => "User", :foreign_key => "target_user_id"
  belongs_to :product            
  
  named_scope :for, lambda { |user_id| { :conditions => {:target_user_id => user_id} } }
  named_scope :about, lambda { |product_id| { :conditions => {:product_id => product_id} } } 
end
