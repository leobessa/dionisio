class AddGroupIdToInvitations < ActiveRecord::Migration
  def self.up
    add_column :invitations, :group_id, :integer
  end

  def self.down
    remove_column :invitations, :group_id
  end
end
