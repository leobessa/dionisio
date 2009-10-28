class Rate < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :rateable, :polymorphic => true      
  validates_uniqueness_of :user_id, :scope => [:rateable_id, :rateable_type] 
end
