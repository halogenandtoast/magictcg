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

ActiveRecord::Schema.define(version: 20130702010035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_sets", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "card_versions", force: true do |t|
    t.integer  "card_set_id"
    t.integer  "card_id"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rarity"
  end

  add_index "card_versions", ["card_id"], name: "index_card_versions_on_card_id", using: :btree
  add_index "card_versions", ["card_set_id"], name: "index_card_versions_on_card_set_id", using: :btree

  create_table "cards", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
    t.string   "types"
  end

  create_table "collected_cards", force: true do |t|
    t.integer  "card_version_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "collecting_set_id"
  end

  add_index "collected_cards", ["card_version_id"], name: "index_collected_cards_on_card_version_id", using: :btree
  add_index "collected_cards", ["collecting_set_id"], name: "index_collected_cards_on_collecting_set_id", using: :btree
  add_index "collected_cards", ["user_id"], name: "index_collected_cards_on_user_id", using: :btree

  create_table "collecting_sets", force: true do |t|
    t.integer  "user_id"
    t.integer  "card_set_id"
    t.integer  "collected_cards_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collecting_sets", ["card_set_id"], name: "index_collecting_sets_on_card_set_id", using: :btree
  add_index "collecting_sets", ["user_id"], name: "index_collecting_sets_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
