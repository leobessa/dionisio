class Product < ActiveRecord::Base
  has_many :reviews
  has_many :offers
  belongs_to :category
  validates_uniqueness_of :name
  has_many :users, :through => :reviews

  def to_s
    name
  end
  
  def photo_alt
    name.gsub(/ /, '+')
  end
  
end