class Product < ActiveRecord::Base
  has_many :reviews
  has_many :offers
  belongs_to :category
  validates_uniqueness_of :name
  has_many :users, :through => :reviews 
  has_many :user_recommendations, :class_name => "UserRecommendation", :foreign_key => "product_id"

  def to_s
    name
  end
  
  def photo_alt
    name.parameterize
  end
  
end