# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111003234334) do

  create_table "site_admins", :force => true do |t|
    t.integer  "site_id"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_admins", ["site_id", "admin_id"], :name => "index_site_admins_on_site_id_and_admin_id", :unique => true
  add_index "site_admins", ["site_id"], :name => "index_site_admins_on_site_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.integer  "website_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["website_id"], :name => "index_users_on_website_id"

  create_table "website_admins", :force => true do |t|
    t.integer  "website_id"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "website_admins", ["website_id", "admin_id"], :name => "index_website_admins_on_website_id_and_admin_id", :unique => true
  add_index "website_admins", ["website_id"], :name => "index_website_admins_on_website_id"

  create_table "websites", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
