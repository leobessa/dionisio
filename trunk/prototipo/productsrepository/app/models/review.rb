class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  validates_presence_of :product, :message => "can't be blank"
  validates_presence_of :user, :message => "can't be blank"
  validates_numericality_of :rating, :message => "is not a number"  
  validates_inclusion_of :rating, :in => 0..5, :message => "must be between 0 and 5"                   
  validates_uniqueness_of :product_id, :scope => :user_id, :on => :create, :message => "must be unique"  
  def to_s
    "#{user.username} rates #{product.name} with #{rating} stars."
  end
end
