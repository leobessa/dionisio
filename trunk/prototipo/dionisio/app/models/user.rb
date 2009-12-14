class User < ActiveRecord::Base
  devise :authenticable
  validates_confirmation_of :password
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => 'deve ser um e-mail'
  validates_uniqueness_of :email
  validates_uniqueness_of :name
  has_many :ratings
  has_many :rated_products, :through => :ratings, :source => :product
  has_many :user_recommendations, :class_name => "UserRecommendation", :foreign_key => "target_id"                    
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name
  
  def is_cold?
    ratings.count < 5
  end
  
  def rate_for(item)  
    id = Product === item ? item.id : item
    rate = Rating.find(:first,:conditions => {:user_id => self.id, :product_id => id})
    rate ? rate.stars : 0
  end
  
  def recommenders
    recommender_ids = UserRecommendation.find(:all,:select => 'DISTINCT sender_id',:conditions => {:target_id => self})
    User.find(recommender_ids.map(&:sender_id))
  end
  
  def rated?(item)
    Rating.find(:first,:conditions => {:user_id => self.id, :product_id => item.id})
  end
end
