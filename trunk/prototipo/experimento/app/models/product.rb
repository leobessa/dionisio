class Product < ActiveRecord::Base
  belongs_to :category
  has_many :ratings
  named_scope :selected, :conditions => {:selected => true}
  validates_inclusion_of :selected, :in => [true,false]
  
  before_validation_on_create do |product| 
    product.selected ||= false 
    true
  end
  
  
end
