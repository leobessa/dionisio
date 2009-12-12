class Product < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10

  belongs_to :category
  has_many :ratings
  named_scope :most_dispersed, :conditions => {:selected => true}
  named_scope :with_ratings_from, (lambda do |user|
    {:select =>  "'products'.*, 'ratings'.stars as 'rating'", 
      :joins => "LEFT JOIN 'ratings' ON 'ratings'.'product_id' = 'products'.id AND 'ratings'.'user_id' = #{user.id}",
      :order => 'popularity DESC, name'}
    end)
    
end
