class Product < ActiveRecord::Base

  belongs_to :category
  has_many :ratings
  named_scope :selected, :conditions => {:selected => true}
  named_scope :with_ratings_from, (lambda do |user|
    {:select =>  "'products'.*, 'ratings'.stars as 'stars', 'ratings'.unknown as 'unknown'", 
      :joins => "LEFT JOIN 'ratings' ON 'ratings'.'product_id' = 'products'.id AND 'ratings'.'user_id' = #{user.id}",
      :order => 'popularity DESC, name'}
    end)
    validates_inclusion_of :selected, :in => [true,false]

    before_validation_on_create do |product| 
      product.selected ||= false 
      true
    end


  end
