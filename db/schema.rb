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

ActiveRecord::Schema.define(version: 20200211041034) do

  create_table "mods", force: :cascade do |t|
    t.string "title"
    t.string "wiki"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mods_servers", id: false, force: :cascade do |t|
    t.integer "server_id", null: false
    t.integer "mod_id", null: false
    t.index ["server_id", "mod_id"], name: "index_mods_servers_on_server_id_and_mod_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.integer "type", default: 0, null: false
    t.text "permission", null: false
    t.string "world", limit: 50, null: false
    t.text "value", null: false
    t.index ["name", "type", "world", "permission"], name: "permissions_Index01"
    t.index ["name", "type", "world"], name: "permissions_Index02"
  end

  create_table "permissions_entity", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.integer "type", default: 0, null: false
    t.integer "default", default: 0, null: false
    t.index ["name", "type"], name: "permissions_entity_Index01", unique: true
  end

  create_table "permissions_inheritance", force: :cascade do |t|
    t.string "child", limit: 50, null: false
    t.string "parent", limit: 50, null: false
    t.integer "type", null: false
    t.string "world", limit: 50
    t.index ["child", "type", "world"], name: "permissions_inheritance_Index01"
    t.index ["parent", "type"], name: "permissions_inheritance_Index02"
  end

  create_table "pex_entities", force: :cascade do |t|
    t.string "name", limit: 50
    t.integer "type", limit: 1
    t.integer "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pex_inheritances", force: :cascade do |t|
    t.string "child", limit: 50
    t.string "parent", limit: 50
    t.integer "type", limit: 1
    t.string "world", limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pex_permissions", force: :cascade do |t|
    t.string "name", limit: 50
    t.integer "type", limit: 1
    t.text "permission"
    t.string "world", limit: 50
    t.text "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.text "text"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "server_stats", force: :cascade do |t|
    t.integer "server_id"
    t.boolean "online"
    t.integer "players"
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["server_id"], name: "index_server_stats_on_server_id"
  end

  create_table "servers", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.string "version"
    t.string "ip"
    t.integer "port"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["short_name"], name: "index_servers_on_short_name", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id"
    t.string "session"
    t.string "serverid"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key"
    t.index ["user_id"], name: "index_sessions_on_user_id"
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "role"
    t.string "cape_file_name"
    t.string "cape_content_type"
    t.integer "cape_file_size", limit: 8
    t.datetime "cape_updated_at"
    t.string "skin_file_name"
    t.string "skin_content_type"
    t.integer "skin_file_size", limit: 8
    t.datetime "skin_updated_at"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "prefix"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
