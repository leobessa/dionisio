class AddStageIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :stage_id, :integer
  end

  def self.down
    remove_column :users, :stage_id
  end
end
