class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  validates_presence_of :product, :on => :create, :message => "can't be blank"
  validates_presence_of :user, :on => :create, :message => "can't be blank"
  validates_numericality_of :rating, :on => :create, :message => "is not a number"
  validates_uniqueness_of :product_id, :scope => :user_id, :on => :create, :message => "must be unique"
  def to_s
    "#{user.username} rates #{product.name} with #{rating} stars."
  end
end
