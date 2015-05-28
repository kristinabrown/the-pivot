# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150527140327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beer_categories", force: :cascade do |t|
    t.integer "category_id"
    t.integer "beer_id"
  end

  add_index "beer_categories", ["beer_id"], name: "index_beer_categories_on_beer_id", using: :btree
  add_index "beer_categories", ["category_id"], name: "index_beer_categories_on_category_id", using: :btree

  create_table "bids", force: :cascade do |t|
    t.integer  "current_price"
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "bids", ["item_id"], name: "index_bids_on_item_id", using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.string   "description"
    t.integer  "starting_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "expiration_date"
    t.integer  "store_id"
    t.integer  "category_id"
    t.boolean  "paid",                    default: false
  end

  add_index "items", ["category_id"], name: "index_items_on_category_id", using: :btree
  add_index "items", ["store_id"], name: "index_items_on_store_id", using: :btree

  create_table "order_beers", force: :cascade do |t|
    t.integer "order_id"
    t.integer "beer_id"
    t.integer "quantity"
  end

  add_index "order_beers", ["beer_id"], name: "index_order_beers_on_beer_id", using: :btree
  add_index "order_beers", ["order_id"], name: "index_order_beers_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
  end

  add_index "orders", ["item_id"], name: "index_orders_on_item_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "fullname"
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone"
    t.string   "display_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "street"
    t.string   "apt_number"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "credit_card"
    t.date     "cc_expiration_date"
    t.integer  "store_id"
  end

  add_foreign_key "beer_categories", "categories"
  add_foreign_key "beer_categories", "items", column: "beer_id"
  add_foreign_key "bids", "items"
  add_foreign_key "bids", "users"
  add_foreign_key "order_beers", "items", column: "beer_id"
  add_foreign_key "order_beers", "orders"
  add_foreign_key "orders", "items"
  add_foreign_key "orders", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
