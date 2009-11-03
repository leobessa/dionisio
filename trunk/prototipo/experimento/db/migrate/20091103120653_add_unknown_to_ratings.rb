class AddUnknownToRatings < ActiveRecord::Migration
  def self.up
    add_column :ratings, :unknown, :boolean
  end

  def self.down
    remove_column :ratings, :unknown
  end
end
