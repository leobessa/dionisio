class CreateSystemRecommendations < ActiveRecord::Migration
  def self.up
    create_table :system_recommendations do |t|
      t.integer :user_id
      t.string :algorithm
      t.integer :product_id
      t.integer :predicted_rating

      t.timestamps
    end
  end

  def self.down
    drop_table :system_recommendations
  end
end
