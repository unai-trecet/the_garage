# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150430160159) do

  create_table "cars", force: :cascade do |t|
    t.integer  "vehicles_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cars", ["vehicles_id"], name: "index_cars_on_vehicles_id"

  create_table "garages", force: :cascade do |t|
    t.integer  "number_levels"
    t.integer  "number_lots"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: :cascade do |t|
    t.integer  "garage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
  end

  add_index "levels", ["garage_id"], name: "index_levels_on_garage_id"

  create_table "lots", force: :cascade do |t|
    t.integer  "garage_id"
    t.integer  "level_id"
    t.integer  "vehicle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
  end

  add_index "lots", ["garage_id"], name: "index_lots_on_garage_id"
  add_index "lots", ["level_id"], name: "index_lots_on_level_id"
  add_index "lots", ["vehicle_id"], name: "index_lots_on_vehicle_id"

  create_table "motorbikes", force: :cascade do |t|
    t.integer "vehicles_id"
  end

  add_index "motorbikes", ["vehicles_id"], name: "index_motorbikes_on_vehicles_id"

  create_table "vehicles", force: :cascade do |t|
    t.integer  "plate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "garage_id"
    t.integer  "lot_id"
    t.integer  "level_id"
  end

  add_index "vehicles", ["plate"], name: "index_vehicles_on_plate"

end
