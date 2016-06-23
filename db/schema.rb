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

ActiveRecord::Schema.define(version: 20160623063341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string  "name"
    t.integer "follow_count"
    t.boolean "active"
  end

  create_table "history_transactions", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "buyer"
    t.string   "owner"
    t.string   "ttype"
    t.string   "bill_picture_file_name"
    t.string   "bill_picture_content_type"
    t.integer  "bill_picture_file_size"
    t.datetime "bill_picture_updated_at"
    t.integer  "user_id"
    t.integer  "merchant_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.string   "alt"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "images", ["imageable_id"], name: "index_images_on_imageable_id", using: :btree

  create_table "itienaries", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "transportation"
    t.string   "location"
    t.float    "lat"
    t.float    "lng"
    t.integer  "image_count",    default: 0
    t.datetime "start_date"
    t.integer  "trip_id"
  end

  add_index "itienaries", ["trip_id"], name: "index_itienaries_on_trip_id", using: :btree

  create_table "merchants", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "location"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "promos", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.float    "lat"
    t.float    "lng"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "visitor_count"
    t.integer  "promotype"
    t.string   "status"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "social_networks", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid",        default: ""
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
    t.string   "link"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "buyer"
    t.string   "owner"
    t.string   "ttype"
    t.string   "bill_picture_file_name"
    t.string   "bill_picture_content_type"
    t.integer  "bill_picture_file_size"
    t.datetime "bill_picture_updated_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "trips", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.string   "currency"
    t.integer  "join_count"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "status"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "authentication_token"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.datetime "dob"
    t.string   "interest"
    t.string   "categories"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "reset_token"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
