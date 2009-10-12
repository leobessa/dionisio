class CreateUserRecommendations < ActiveRecord::Migration
  def self.up     
    create_table :user_recommendations do |t|
      t.integer :recommender_id, :null => false
      t.integer :target_user_id, :null => false
      t.integer :product_id, :null => false
      t.integer :vote

      t.timestamps
    end
  end

  def self.down
    drop_table :user_recommendations
  end
end
