class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :path
      t.string :img_src
      t.string :img_alt
      t.string :brand
      t.integer :category_id
      t.boolean :selected
      t.decimal :price, :precision => 10, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
