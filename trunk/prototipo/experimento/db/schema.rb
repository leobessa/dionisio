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

ActiveRecord::Schema.define(:version => 20091111213338) do

  create_table "admins", :force => true do |t|
    t.string   "email",              :null => false
    t.string   "encrypted_password", :null => false
    t.string   "password_salt",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "path"
    t.string   "photo"
    t.string   "img_alt"
    t.string   "brand"
    t.integer  "category_id"
    t.boolean  "selected"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "popularity",  :default => 0
  end

  add_index "products", ["category_id"], :name => "index_category_id_on_products"
  add_index "products", ["name"], :name => "index_name_on_products"

  create_table "rates", :force => true do |t|
    t.integer  "user_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.string   "dimension"
    t.integer  "stars"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id"], :name => "index_rates_on_rateable_id"
  add_index "rates", ["user_id"], :name => "index_rates_on_user_id"

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "stars"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "unknown"
  end

  create_table "recommendation_guides", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "target_id"
    t.integer  "times"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stages", :force => true do |t|
    t.integer  "number"
    t.boolean  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_recommendations", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "target_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.integer  "invitation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "age_group"
    t.string   "sex"
    t.integer  "stage_number"
    t.integer  "group_id"
  end

end
