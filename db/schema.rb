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

ActiveRecord::Schema[8.1].define(version: 2026_04_02_122112) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.decimal "price"
    t.integer "quantity"
    t.string "sku"
    t.datetime "updated_at", null: false
    t.string "url_image"
  end

  create_table "pokedex", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "pk_type"
    t.integer "pokedex_id"
    t.datetime "updated_at", null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "level"
    t.boolean "on_team"
    t.bigint "pokedex_id", null: false
    t.bigint "trainer_id", null: false
    t.datetime "updated_at", null: false
    t.index ["pokedex_id"], name: "index_pokemons_on_pokedex_id"
    t.index ["trainer_id"], name: "index_pokemons_on_trainer_id"
  end

  create_table "trainers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "money"
    t.string "name"
    t.integer "trainer_id"
    t.datetime "updated_at", null: false
    t.string "url_image"
  end

  add_foreign_key "pokemons", "pokedex"
  add_foreign_key "pokemons", "trainers"
end
