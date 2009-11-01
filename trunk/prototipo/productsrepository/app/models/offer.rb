class Offer < ActiveRecord::Base
  validates_uniqueness_of :path, :scope => :business_id, :on => :create, :message => "must be unique"
  belongs_to :product
  belongs_to :business
  validates_presence_of :product
  validates_presence_of :business, :on => :create, :message => "can't be blank"
  validates_presence_of :path, :on => :create, :message => "can't be blank"
  
  def name
    product.name
  end
  
  def category
    product.category
  end
  
  def brand
    product.brand
  end
  
  def description
    product.description
  end
  
  def popularity
    product.popularity
  end
  
  def link
    business.url + path
  end
  
end
