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

ActiveRecord::Schema.define(version: 2019_03_24_150158) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "films", force: :cascade do |t|
    t.string "title"
    t.integer "episode_id"
    t.string "opening_crawl"
    t.string "director"
    t.string "producer"
    t.string "release_date"
    t.string "created_at_swapi"
    t.string "edited_at_swapi"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "films_people", id: false, force: :cascade do |t|
    t.bigint "film_id", null: false
    t.bigint "person_id", null: false
  end

  create_table "films_planets", id: false, force: :cascade do |t|
    t.bigint "film_id", null: false
    t.bigint "planet_id", null: false
  end

  create_table "films_starships", id: false, force: :cascade do |t|
    t.bigint "film_id", null: false
    t.bigint "starship_id", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.integer "height"
    t.integer "mass"
    t.string "hair_color"
    t.string "skin_color"
    t.string "eye_color"
    t.string "birth_year"
    t.string "gender"
    t.string "homeworld"
    t.string "created_at_swapi"
    t.string "edited_at_swapi"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "planet_id"
    t.index ["planet_id"], name: "index_people_on_planet_id"
  end

  create_table "people_starships", id: false, force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "starship_id", null: false
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.integer "rotation_period"
    t.integer "orbital_period"
    t.integer "diameter"
    t.string "climate"
    t.string "gravity"
    t.string "terrain"
    t.integer "surface_water"
    t.string "population"
    t.string "created_at_swapi"
    t.string "edited_at_swapi"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "starships", force: :cascade do |t|
    t.string "name"
    t.string "model"
    t.string "manufacturer"
    t.string "cost_in_credits"
    t.integer "length"
    t.string "max_atmosphering_speed"
    t.integer "crew"
    t.integer "passengers"
    t.string "cargo_capacity"
    t.string "consumables"
    t.string "hyperdrive_rating"
    t.integer "MGLT"
    t.string "starship_class"
    t.string "created_at_swapi"
    t.string "edited_at_swapi"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "people", "planets"
end
