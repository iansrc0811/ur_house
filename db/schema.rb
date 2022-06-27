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

ActiveRecord::Schema[7.0].define(version: 2022_06_27_152601) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_districts_on_city_id"
  end

  create_table "residences", force: :cascade do |t|
    t.string "title", null: false
    t.integer "price", null: false
    t.bigint "city_id", null: false
    t.bigint "district_id", null: false
    t.string "address", null: false
    t.integer "room_number", null: false
    t.string "mrt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_residences_on_city_id"
    t.index ["district_id"], name: "index_residences_on_district_id"
  end

  add_foreign_key "districts", "cities"
  add_foreign_key "residences", "cities"
  add_foreign_key "residences", "districts"
end
