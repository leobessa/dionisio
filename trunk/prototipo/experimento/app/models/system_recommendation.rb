class SystemRecommendation < ActiveRecord::Base
  validates_presence_of :algorithm
  validates_presence_of :predicted_rating
  validates_presence_of :product_id
  validates_presence_of :user_id
  validates_uniqueness_of :algorithm, :scope => [:user_id,:product_id]
  validates_inclusion_of :algorithm, :in => %w( item profile trust )
  belongs_to :user
  belongs_to :product
end
