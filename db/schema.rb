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

ActiveRecord::Schema.define(version: 2022_08_05_142632) do

  create_table "languages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "amount", null: false
    t.index ["name"], name: "index_languages_on_name", unique: true
  end

  create_table "locations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_locations_on_name", unique: true
  end

  create_table "profile_languages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "language_id", null: false
    t.index ["language_id"], name: "index_profile_languages_on_language_id"
    t.index ["profile_id"], name: "index_profile_languages_on_profile_id"
  end

  create_table "profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "avatar", null: false
    t.string "url", null: false
    t.string "repos_url", null: false
    t.string "name"
    t.string "company"
    t.string "blog"
    t.string "email"
    t.string "bio"
    t.string "twitter"
    t.integer "public_repos_count", null: false
    t.integer "public_gists_count", null: false
    t.integer "followers_count", null: false
    t.integer "followings_count", null: false
    t.date "git_date", null: false
    t.bigint "location_id", null: false
    t.index ["location_id"], name: "index_profiles_on_location_id"
    t.index ["nickname"], name: "index_profiles_on_nickname", unique: true
  end

  create_table "repo_languages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "repo_id", null: false
    t.bigint "language_id", null: false
    t.index ["language_id"], name: "index_repo_languages_on_language_id"
    t.index ["repo_id"], name: "index_repo_languages_on_repo_id"
  end

  create_table "repos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.string "description"
    t.string "languages_url", null: false
    t.boolean "is_active"
    t.date "git_date", null: false
    t.bigint "profile_id", null: false
    t.index ["name"], name: "index_repos_on_name"
    t.index ["profile_id"], name: "index_repos_on_profile_id"
  end

  add_foreign_key "profile_languages", "languages"
  add_foreign_key "profile_languages", "profiles"
  add_foreign_key "profiles", "locations"
  add_foreign_key "repo_languages", "languages"
  add_foreign_key "repo_languages", "repos"
  add_foreign_key "repos", "profiles"
end
