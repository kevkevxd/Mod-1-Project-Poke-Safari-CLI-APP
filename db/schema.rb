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

ActiveRecord::Schema.define(version: 2020_07_30_174357) do

  create_table "pokemons", force: :cascade do |t|
    t.string "nickname"
    t.integer "user_id"
    t.integer "species_id"
  end

  create_table "species", force: :cascade do |t|
    t.string "name"
    t.integer "type_id"
    t.integer "stat"
  end

  create_table "types", force: :cascade do |t|
    t.string "type_one"
    t.string "type_two"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "gender"
    t.string "trainer_name"
    t.integer "currency"
    t.integer "balls"
  end

end
