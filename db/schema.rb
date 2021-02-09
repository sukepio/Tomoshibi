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

ActiveRecord::Schema.define(version: 2021_02_09_093831) do

  create_table "admin_events", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "first_name_kana", null: false
    t.string "last_name_kana", null: false
    t.date "date_of_birth", null: false
    t.string "phone_number", null: false
    t.string "login_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["first_name"], name: "index_admins_on_first_name"
    t.index ["first_name_kana"], name: "index_admins_on_first_name_kana"
    t.index ["last_name"], name: "index_admins_on_last_name"
    t.index ["last_name_kana"], name: "index_admins_on_last_name_kana"
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "households", force: :cascade do |t|
    t.string "living_space", default: "A-1", null: false
    t.string "address", null: false
    t.string "house_damage_situation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "head_last_name"
    t.string "head_first_name"
  end

  create_table "meals", force: :cascade do |t|
    t.string "menu"
    t.string "detail"
    t.datetime "start"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sender"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["title"], name: "index_posts_on_title"
  end

  create_table "residents", force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "first_name_kana", null: false
    t.string "last_name_kana", null: false
    t.date "date_of_birth", null: false
    t.string "phone_number", null: false
    t.string "login_id", null: false
    t.boolean "has_left", default: false, null: false
    t.string "self_message", default: "みなさんの支えに感謝！"
    t.text "information"
    t.boolean "photo_accepted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "gender", default: 0, null: false
    t.integer "household_id"
    t.index ["first_name"], name: "index_residents_on_first_name"
    t.index ["first_name_kana"], name: "index_residents_on_first_name_kana"
    t.index ["last_name"], name: "index_residents_on_last_name"
    t.index ["last_name_kana"], name: "index_residents_on_last_name_kana"
    t.index ["reset_password_token"], name: "index_residents_on_reset_password_token", unique: true
  end

end
