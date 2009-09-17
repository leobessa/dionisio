class UserRecommendation < ActiveRecord::Base
  belongs_to :recommender, :class_name => "User", :foreign_key => "recommender_id" 
  belongs_to :target_user, :class_name => "User", :foreign_key => "target_user_id"
  belongs_to :product
end
