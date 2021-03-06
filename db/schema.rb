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

ActiveRecord::Schema.define(version: 20171210184822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "houses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "street", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip_code", null: false
    t.integer "asking_amount"
    t.integer "total_sqft"
    t.string "house_profile_pic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_houses_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "house_id"
    t.bigint "user_id"
    t.string "room", null: false
    t.integer "rating", default: 0
    t.text "pros"
    t.text "cons"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_notes_on_house_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
