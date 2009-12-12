class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.belongs_to :user
      t.belongs_to :product
      t.integer :stars

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
