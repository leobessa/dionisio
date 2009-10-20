class AddNameAgeGroupAndSexToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :age_group, :string
    add_column :users, :sex, :string
  end

  def self.down
    remove_column :users, :sex
    remove_column :users, :age_group
    remove_column :users, :name
  end
end
