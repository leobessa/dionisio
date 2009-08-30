class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :brand
      t.belongs_to :category
      t.text :description
      t.string :name
      t.string :photo
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
