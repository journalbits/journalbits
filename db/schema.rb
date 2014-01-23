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

ActiveRecord::Schema.define(version: 20140123155517) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fitbit_activity_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.integer  "calories"
    t.float    "distance"
    t.integer  "steps"
    t.integer  "active_minutes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fitbit_sleep_entries", force: true do |t|
    t.integer  "minutes_asleep"
    t.integer  "minutes_awake"
    t.integer  "minutes_to_fall_asleep"
    t.integer  "efficiency"
    t.integer  "times_awake"
    t.string   "start_time"
    t.integer  "user_id"
    t.string   "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "github_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "sha"
    t.string   "time_created"
    t.string   "commit_message"
    t.string   "committer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commit_url"
  end

  create_table "rescue_time_entries", force: true do |t|
    t.string   "activity_1"
    t.integer  "time_spent_1"
    t.string   "activity_2"
    t.integer  "time_spent_2"
    t.string   "activity_3"
    t.integer  "time_spent_3"
    t.string   "activity_4"
    t.integer  "time_spent_4"
    t.string   "activity_5"
    t.integer  "time_spent_5"
    t.string   "date"
    t.integer  "productivity"
    t.datetime "created_at"
    t.integer  "user_id"
  end

  create_table "twitter_entries", force: true do |t|
    t.text     "text"
    t.string   "media"
    t.string   "kind"
    t.string   "tweeter"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "tweet_id",     limit: 8
    t.string   "time_created"
    t.string   "tweet_url"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "twitter_uid"
    t.string   "twitter_username"
    t.string   "twitter_oauth_token"
    t.string   "twitter_oauth_secret"
    t.string   "rescue_time_key"
    t.string   "github_access_token"
    t.string   "wunderlist_token"
    t.string   "fitbit_oauth_token"
    t.string   "fitbit_oauth_secret"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wunderlist_entries", force: true do |t|
    t.string   "completed_at"
    t.string   "time_created"
    t.string   "title"
    t.string   "list"
    t.integer  "user_id"
    t.string   "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
