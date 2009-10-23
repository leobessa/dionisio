class CreateRates < ActiveRecord::Migration
  def self.up
    create_table :rates do |t|
      t.integer :user_id
      t.integer :rateable_id
      t.string :rateable_type
      t.string :dimension
      t.integer :stars

      t.timestamps
    end
    add_index "rates", ["rateable_id"], :name => "index_rates_on_rateable_id"
    add_index "rates", ["user_id"], :name => "index_rates_on_user_id"
  end

  def self.down
    drop_table :rates
  end
end
