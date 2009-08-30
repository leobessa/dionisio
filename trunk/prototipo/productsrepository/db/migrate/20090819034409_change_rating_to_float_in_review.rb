class ChangeRatingToFloatInReview < ActiveRecord::Migration
  def self.up
    change_column :reviews, :rating, :float
  end

  def self.down 
    change_column :reviews, :rating, :integer
  end
end
