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

ActiveRecord::Schema.define(version: 20180408124111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "games", force: :cascade do |t|
    t.bigint "host_id"
    t.bigint "visitor_id"
    t.boolean "allows_tie", default: true
    t.datetime "date"
    t.string "place", default: ""
    t.bigint "round_id"
    t.integer "host_score"
    t.integer "visitor_score"
    t.integer "status", default: 0
    t.index ["host_id"], name: "index_games_on_host_id"
    t.index ["round_id"], name: "index_games_on_round_id"
    t.index ["visitor_id"], name: "index_games_on_visitor_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "name"
    t.bigint "tournament_id"
    t.index ["tournament_id"], name: "index_rounds_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.string "flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tournament_id"
    t.index ["tournament_id"], name: "index_teams_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "logo"
    t.string "slug"
    t.index ["user_id"], name: "index_tournaments_on_user_id"
  end

  create_table "user_guesses", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "user_id"
    t.integer "host_score", default: 0
    t.integer "visitor_score", default: 0
    t.index ["game_id"], name: "index_user_guesses_on_game_id"
    t.index ["user_id"], name: "index_user_guesses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "games", "rounds"
  add_foreign_key "games", "teams", column: "host_id"
  add_foreign_key "games", "teams", column: "visitor_id"
  add_foreign_key "rounds", "tournaments"
  add_foreign_key "teams", "tournaments"
  add_foreign_key "user_guesses", "games"
  add_foreign_key "user_guesses", "users"
end
