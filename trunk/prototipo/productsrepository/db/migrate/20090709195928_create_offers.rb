class CreateOffers < ActiveRecord::Migration
  def self.up
    create_table :offers do |t|
      t.integer :product_id
      t.integer :business_id
      t.decimal :list_price, :limit => 10, :precision => 10, :scale => 2
      t.string :path
      t.string :img_src
      t.string :img_alt
      t.string :currency
      t.timestamps
    end
  end

  def self.down
    drop_table :offers
  end
end
