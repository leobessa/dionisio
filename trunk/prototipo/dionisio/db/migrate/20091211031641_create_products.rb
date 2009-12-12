class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :path
      t.string :photo
      t.string :img_alt
      t.belongs_to :category
      t.boolean :selected
      t.decimal :price
      t.integer :popularity
    end
  end

  def self.down
    drop_table :products
  end
end
