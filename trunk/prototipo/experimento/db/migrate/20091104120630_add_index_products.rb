class AddIndexProducts < ActiveRecord::Migration
  def self.up
    add_index "products", ["name"], :name => "index_name_on_products"
    add_index "products", ["category_id"], :name => "index_category_id_on_products"
  end

  def self.down
    remove_index "products", "name"
    remove_index "products", "category_id"
  end
end
