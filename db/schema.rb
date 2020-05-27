# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_27_160452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_columns", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.bigint "column_id", null: false
    t.bigint "row_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "board_ship_id"
    t.index ["board_id", "column_id", "row_id"], name: "index_board_columns_on_board_id_and_column_id_and_row_id", unique: true
    t.index ["board_id"], name: "index_board_columns_on_board_id"
    t.index ["board_ship_id"], name: "index_board_columns_on_board_ship_id"
    t.index ["column_id"], name: "index_board_columns_on_column_id"
    t.index ["row_id"], name: "index_board_columns_on_row_id"
    t.index ["status"], name: "index_board_columns_on_status"
  end

  create_table "board_ships", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.bigint "ship_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["board_id", "ship_id"], name: "index_board_ships_on_board_id_and_ship_id", unique: true
    t.index ["board_id"], name: "index_board_ships_on_board_id"
    t.index ["ship_id"], name: "index_board_ships_on_ship_id"
  end

  create_table "boards", force: :cascade do |t|
    t.integer "board_type", default: 0
    t.bigint "game_id", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["board_type"], name: "index_boards_on_board_type"
    t.index ["game_id"], name: "index_boards_on_game_id"
    t.index ["player_id"], name: "index_boards_on_player_id"
  end

  create_table "columns", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_columns_on_name"
  end

  create_table "games", force: :cascade do |t|
    t.string "uuid", default: "", null: false
    t.bigint "player_1_id"
    t.bigint "player_2_id"
    t.bigint "winner_id"
    t.bigint "loser_id"
    t.integer "progress", default: 0
    t.integer "turn", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["loser_id"], name: "index_games_on_loser_id"
    t.index ["player_1_id"], name: "index_games_on_player_1_id"
    t.index ["player_2_id"], name: "index_games_on_player_2_id"
    t.index ["progress"], name: "index_games_on_progress"
    t.index ["turn"], name: "index_games_on_turn"
    t.index ["uuid"], name: "index_games_on_uuid"
    t.index ["winner_id"], name: "index_games_on_winner_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "rows", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_rows_on_name"
  end

  create_table "ships", force: :cascade do |t|
    t.integer "ship_type", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ship_type"], name: "index_ships_on_ship_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "board_columns", "boards"
  add_foreign_key "board_columns", "columns"
  add_foreign_key "board_columns", "rows"
  add_foreign_key "board_ships", "boards"
  add_foreign_key "board_ships", "ships"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
end
