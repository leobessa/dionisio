class User < ActiveRecord::Base           
  include Recommender::ActiveRecordBased    
  default_scope :order => :username
  acts_as_authentic
  has_many :reviews
  has_many :products, :through => :reviews  
  
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

#  acts_as_recommendable :products, :through => :reviews
  
  def to_s
    username
  end
  
  def self.search(search)
    if search
      find(:all, :conditions => ['username LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end  
  
  def recommended_products
    Recommender::ActiveRecordBased.recommendations self, :algorithm  => :sim_pearson, :limit => 3
  end
  
end
