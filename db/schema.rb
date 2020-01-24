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

ActiveRecord::Schema.define(version: 2020_01_18_212337) do

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

  create_table "project_state_transitions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "project_id", null: false
    t.string "from_state", limit: 50
    t.string "to_state", limit: 50, null: false
    t.string "event", limit: 50
    t.boolean "most_recent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_state_transitions_on_project_id"
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

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "project_subcategory_id", null: false
    t.string "project_type", null: false
    t.string "state", null: false
    t.string "slug", limit: 200, null: false
    t.string "title", limit: 80, null: false
    t.string "short_description", limit: 255
    t.text "full_description"
    t.datetime "deadline", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_subcategory_id"], name: "index_projects_on_project_subcategory_id"
    t.index ["project_type"], name: "index_projects_on_project_type"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
    t.index ["state"], name: "index_projects_on_state"
    t.index ["title"], name: "index_projects_on_title", unique: true
  end

  add_foreign_key "project_state_transitions", "projects"
  add_foreign_key "project_subcategories", "project_categories"
  add_foreign_key "projects", "project_subcategories"
end
