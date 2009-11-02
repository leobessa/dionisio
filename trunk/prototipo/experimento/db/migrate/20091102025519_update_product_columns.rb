class UpdateProductColumns < ActiveRecord::Migration
  def self.up
    rename_column :products, :img_src, :photo
    add_column :products, :popularity, :integer, :default => 0
  end

  def self.down
    remove_column :products, :popularity
    rename_column :products, :photo
  end
end
