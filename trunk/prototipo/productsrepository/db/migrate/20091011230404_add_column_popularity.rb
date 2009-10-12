class AddColumnPopularity < ActiveRecord::Migration
  def self.up
    add_column :products, :popularity, :integer, :default => 0
  end
  
  def self.down
    remove_column :products, :popularity
  end
end
