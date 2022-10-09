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

ActiveRecord::Schema[7.0].define(version: 2022_10_08_142158) do
  create_table "deadlines", force: :cascade do |t|
    t.integer "min"
    t.integer "max"
    t.integer "time"
    t.integer "transport_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transport_mode_id"], name: "index_deadlines_on_transport_mode_id"
  end

  create_table "distance_tables", force: :cascade do |t|
    t.integer "min"
    t.integer "max"
    t.decimal "value", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transport_mode_id", null: false
    t.index ["transport_mode_id"], name: "index_distance_tables_on_transport_mode_id"
  end

  create_table "order_starts", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "transport_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_starts_on_order_id"
    t.index ["transport_mode_id"], name: "index_order_starts_on_transport_mode_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "takeout_address"
    t.string "code"
    t.integer "weight"
    t.integer "heigth"
    t.integer "width"
    t.integer "depth"
    t.string "delivery_address"
    t.string "name"
    t.string "email"
    t.string "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.integer "total_distance"
  end

  create_table "transport_modes", force: :cascade do |t|
    t.string "name"
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "min_weight"
    t.integer "max_weight"
    t.decimal "fixed_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "nameplate"
    t.string "vehicle_brand"
    t.string "vehicle_model"
    t.integer "manifacture_year"
    t.integer "maximum_load"
    t.integer "transport_mode_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transport_mode_id"], name: "index_vehicles_on_transport_mode_id"
  end

  create_table "weight_tables", force: :cascade do |t|
    t.integer "min"
    t.integer "max"
    t.decimal "value", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transport_mode_id", null: false
    t.index ["transport_mode_id"], name: "index_weight_tables_on_transport_mode_id"
  end

  add_foreign_key "deadlines", "transport_modes"
  add_foreign_key "distance_tables", "transport_modes"
  add_foreign_key "order_starts", "orders"
  add_foreign_key "order_starts", "transport_modes"
  add_foreign_key "vehicles", "transport_modes"
  add_foreign_key "weight_tables", "transport_modes"
end
