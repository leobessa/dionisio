class Product < ActiveRecord::Base
  belongs_to :category
  ajaxful_rateable :stars => 5
  has_many :rates, :as => :rateable
  named_scope :selected, :conditions => {:selected => true}
  
end
