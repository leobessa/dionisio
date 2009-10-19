class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :encrypted_password
      t.string :password_salt
      t.string :reset_password_token
      t.integer :invitation_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
