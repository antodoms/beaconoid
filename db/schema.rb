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

ActiveRecord::Schema.define(version: 20170523053819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advertisements", force: :cascade do |t|
    t.string   "name"
    t.integer  "beacon_id"
    t.integer  "category_id"
    t.float    "price"
    t.string   "description"
    t.integer  "created_by_id"
    t.integer  "modified_by_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["beacon_id"], name: "index_advertisements_on_beacon_id", using: :btree
    t.index ["category_id"], name: "index_advertisements_on_category_id", using: :btree
    t.index ["created_by_id"], name: "index_advertisements_on_created_by_id", using: :btree
    t.index ["modified_by_id"], name: "index_advertisements_on_modified_by_id", using: :btree
  end

  create_table "beacons", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "name"
    t.string   "current_status"
    t.string   "unique_reference"
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "created_by_id"
    t.integer  "modified_by_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["created_by_id"], name: "index_beacons_on_created_by_id", using: :btree
    t.index ["modified_by_id"], name: "index_beacons_on_modified_by_id", using: :btree
    t.index ["store_id"], name: "index_beacons_on_store_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "created_by_id"
    t.integer  "modified_by_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["created_by_id"], name: "index_categories_on_created_by_id", using: :btree
    t.index ["modified_by_id"], name: "index_categories_on_modified_by_id", using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "unique_id"
    t.string   "image_url"
    t.integer  "created_by_id"
    t.integer  "modified_by_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "sales"
    t.index ["created_by_id"], name: "index_stores_on_created_by_id", using: :btree
    t.index ["modified_by_id"], name: "index_stores_on_modified_by_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "role"
    t.string   "nickname"
    t.string   "name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
