class ChangeStageIdToStageNumberInUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :stage_number, :integer
    remove_column :users, :stage_id
  end

  def self.down
    add_column :users, :stage_id, :integer
    remove_column :users, :stage_number
  end
end
