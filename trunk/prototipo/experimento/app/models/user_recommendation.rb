class UserRecommendation < ActiveRecord::Base
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :target, :class_name => "User", :foreign_key => "target_id"
  belongs_to :product, :class_name => "Product", :foreign_key => "product_id"
  validates_presence_of :sender_id
  validates_presence_of :target_id
  validates_presence_of :product_id
  validates_uniqueness_of :product_id, :scope => [:sender_id,:target_id], :message => "must be unique"
  
  
end
