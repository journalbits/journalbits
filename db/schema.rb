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

ActiveRecord::Schema.define(version: 20140712145153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.integer  "user_id"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "days", ["slug"], name: "index_days_on_slug", using: :btree

  create_table "evernote_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "oauth_token"
    t.datetime "token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",           default: true
    t.boolean  "activated",        default: true
    t.string   "username"
  end

  create_table "evernote_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.string   "note_id"
    t.string   "kind"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "evernote_account_id"
  end

  create_table "facebook_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "oauth_token"
    t.datetime "token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",           default: true
    t.boolean  "activated",        default: true
    t.string   "name"
  end

  create_table "facebook_photo_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.string   "photo_id"
    t.string   "source_url"
    t.string   "medium_url"
    t.string   "link_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facebook_account_id"
  end

  create_table "fitbit_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",       default: true
    t.boolean  "activated",    default: true
    t.string   "name"
  end

  create_table "fitbit_activity_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.integer  "calories"
    t.float    "distance"
    t.integer  "steps"
    t.integer  "active_minutes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fitbit_account_id"
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
    t.integer  "fitbit_account_id"
  end

  create_table "fitbit_weight_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.float    "weight"
    t.string   "weight_unit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fitbit_account_id"
  end

  create_table "github_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",       default: true
    t.boolean  "activated",    default: true
    t.string   "username"
  end

  create_table "github_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "sha"
    t.string   "date"
    t.string   "commit_message"
    t.string   "committer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commit_url"
    t.integer  "github_account_id"
    t.boolean  "private"
  end

  create_table "health_graph_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",       default: true
    t.boolean  "activated",    default: true
    t.string   "username"
  end

  create_table "health_graph_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.integer  "time_asleep"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "health_graph_account_id"
  end

  create_table "instagram_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "oauth_token"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",      default: true
    t.boolean  "activated",   default: true
    t.string   "username"
  end

  create_table "instagram_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.string   "kind"
    t.string   "thumbnail_url"
    t.string   "standard_url"
    t.string   "caption"
    t.string   "link_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "instagram_account_id"
  end

  create_table "instapaper_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",       default: true
    t.boolean  "activated",    default: true
    t.string   "name"
  end

  create_table "instapaper_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.string   "bookmark_id"
    t.string   "url"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "instapaper_account_id"
  end

  create_table "lastfm_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",     default: true
    t.boolean  "activated",  default: true
  end

  create_table "lastfm_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.string   "artist"
    t.string   "track"
    t.string   "uts"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lastfm_account_id"
  end

  create_table "moves_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "oauth_token"
    t.string   "refresh_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",        default: true
    t.boolean  "activated",     default: true
  end

  create_table "moves_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.string   "activity"
    t.integer  "duration"
    t.integer  "distance"
    t.integer  "steps"
    t.integer  "calories"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "moves_account_id"
  end

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  add_index "oauth_applications", ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type", using: :btree
  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "pocket_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "oauth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",      default: true
    t.boolean  "activated",   default: true
  end

  create_table "pocket_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.string   "url"
    t.string   "title"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pocket_account_id"
  end

  create_table "rescue_time_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",     default: true
    t.boolean  "activated",  default: true
  end

  create_table "rescue_time_entries", force: true do |t|
    t.string  "activity_1"
    t.integer "time_spent_1"
    t.string  "activity_2"
    t.integer "time_spent_2"
    t.string  "activity_3"
    t.integer "time_spent_3"
    t.string  "activity_4"
    t.integer "time_spent_4"
    t.string  "activity_5"
    t.integer "time_spent_5"
    t.integer "productivity"
    t.integer "user_id"
    t.string  "date"
    t.integer "rescue_time_account_id"
  end

  create_table "twitter_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "username"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",       default: true
    t.boolean  "activated",    default: true
  end

  create_table "twitter_entries", force: true do |t|
    t.text     "text"
    t.string   "media"
    t.string   "kind"
    t.string   "tweeter"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "tweet_id",           limit: 8
    t.string   "date"
    t.string   "tweet_url"
    t.integer  "twitter_account_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                               default: "",    null: false
    t.string   "encrypted_password",                  default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       default: 0,     null: false
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
    t.string   "pocket_oauth_token"
    t.string   "rdio_oauth_token"
    t.string   "rdio_oauth_secret"
    t.string   "facebook_oauth_token"
    t.string   "facebook_token_expires_at"
    t.string   "whatpulse_username"
    t.string   "evernote_oauth_token"
    t.string   "evernote_token_expires_at"
    t.string   "instagram_oauth_token"
    t.string   "instagram_uid"
    t.string   "instapaper_oauth_token"
    t.string   "instapaper_oauth_secret"
    t.string   "lastfm_username"
    t.string   "username"
    t.string   "slug"
    t.integer  "clef_id",                   limit: 8
    t.string   "moves_oauth_token"
    t.string   "moves_refresh_token"
    t.string   "health_graph_access_token"
    t.boolean  "public",                              default: false
    t.integer  "time_zone"
    t.boolean  "daily_email",                         default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

  create_table "whatpulse_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",     default: true
    t.boolean  "activated",  default: true
  end

  create_table "whatpulse_entries", force: true do |t|
    t.integer  "user_id"
    t.string   "date"
    t.string   "pulse_id"
    t.string   "keys"
    t.string   "clicks"
    t.integer  "download_mb"
    t.integer  "upload_mb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "whatpulse_account_id"
  end

  create_table "wunderlist_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",     default: true
    t.boolean  "activated",  default: true
  end

  create_table "wunderlist_entries", force: true do |t|
    t.string   "completed_at"
    t.string   "date"
    t.string   "title"
    t.string   "list"
    t.integer  "user_id"
    t.string   "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kind"
    t.integer  "wunderlist_account_id"
  end

end
