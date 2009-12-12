# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091211033948) do

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "products", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.string  "path"
    t.string  "photo"
    t.string  "img_alt"
    t.integer "category_id"
    t.boolean "selected"
    t.decimal "price"
    t.integer "popularity"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "stars"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",              :limit => 100, :null => false
    t.string   "encrypted_password", :limit => 40,  :null => false
    t.string   "password_salt",      :limit => 20,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
