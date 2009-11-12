class CreateRecommendationGuides < ActiveRecord::Migration
  def self.up
    create_table :recommendation_guides do |t|
      t.integer :sender_id
      t.integer :target_id
      t.integer :times
      t.timestamps
    end
  end
  
  def self.down
    drop_table :recommendation_guides
  end
end
