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

ActiveRecord::Schema.define(version: 20160120035704) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "content"
    t.text     "participant_id"
    t.text     "tag"
    t.string   "city"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "recommend"
    t.integer  "want_join"
    t.integer  "admin_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "province"
    t.string   "district"
    t.string   "detail_addr"
    t.string   "picture_path"
  end

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comment_activities", force: :cascade do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "activity_id"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "Name"
    t.string   "Sex"
    t.text     "Tag"
    t.text     "In_Activity"
    t.text     "Sponsor_Activity"
    t.string   "Telephone"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "Email"
    t.text     "readed"
    t.text     "unreaded"
    t.string   "password_digest"
  end

end
