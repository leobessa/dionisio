class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  validates_uniqueness_of :product_id, :scope => :user_id
end
