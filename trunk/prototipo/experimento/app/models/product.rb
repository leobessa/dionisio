class Product < ActiveRecord::Base
  belongs_to :category
  ajaxful_rateable :stars => 5
  has_many :rates, :as => :rateable
  named_scope :selected, :conditions => {:selected => true}
  named_scope :not_selected, :conditions => {:selected => false}
  validates_inclusion_of :selected, :in => [true,false]
  
  before_validation_on_create do |product| 
    product.selected ||= false 
    true
  end
  
  
end
