class CreateUserRecommendations < ActiveRecord::Migration
  def self.up
    create_table :user_recommendations do |t|
      t.integer :sender_id
      t.integer :target_id
      t.integer :product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_recommendations
  end
end
