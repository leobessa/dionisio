class User < ActiveRecord::Base
  devise :authenticable
  validates_confirmation_of :password
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => 'deve ser um e-mail'
  validates_uniqueness_of :email
  has_many :ratings
  has_many :rated_products, :through => :ratings, :source => :product
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  
  def is_cold?
    ratings.count < 5
  end
  
  def rate_for(item)  
    id = Product === item ? item.id : item
    rate = Rating.find(:first,:conditions => {:user_id => self.id, :product_id => id})
    rate ? rate.stars : 0
  end
end
