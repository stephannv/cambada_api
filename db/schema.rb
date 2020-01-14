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

ActiveRecord::Schema.define(version: 2020_01_10_230851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "project_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", limit: 64, null: false
    t.string "slug", limit: 128, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_project_categories_on_slug", unique: true
    t.index ["title"], name: "index_project_categories_on_title", unique: true
  end

  create_table "project_subcategories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "project_category_id", null: false
    t.string "title", limit: 64, null: false
    t.string "slug", limit: 128, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_category_id", "slug"], name: "index_project_subcategories_on_project_category_id_and_slug", unique: true
    t.index ["project_category_id", "title"], name: "index_project_subcategories_on_project_category_id_and_title", unique: true
    t.index ["project_category_id"], name: "index_project_subcategories_on_project_category_id"
  end

  add_foreign_key "project_subcategories", "project_categories"
end
