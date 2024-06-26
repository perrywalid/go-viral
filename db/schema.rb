# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_25_181736) do
  create_table "jwt_denylists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweets", force: :cascade do |t|
    t.string "post_id"
    t.integer "user_id"
    t.string "tweet_id"
    t.datetime "creation_date"
    t.text "text"
    t.string "language"
    t.integer "favorite_count"
    t.integer "retweet_count"
    t.integer "reply_count"
    t.integer "quote_count"
    t.integer "views"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_statistics", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "platform"
    t.integer "followers"
    t.integer "posts"
    t.integer "likes"
    t.integer "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "following"
    t.index ["user_id"], name: "index_user_statistics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "facebook_handle"
    t.string "instagram_handle"
    t.string "twitter_handle"
    t.string "tiktok_handle"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "user_statistics", "users"
end