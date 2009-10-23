class Product < ActiveRecord::Base
  belongs_to :category
  ajaxful_rateable :stars => 5
end
