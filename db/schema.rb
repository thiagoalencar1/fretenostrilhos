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

ActiveRecord::Schema[7.0].define(version: 2022_05_30_231320) do
  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "carriers", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "email_domain"
    t.string "taxpayer_number"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "minimum_price", default: "5.0", null: false
  end

  create_table "delivery_distances", force: :cascade do |t|
    t.integer "from_km"
    t.integer "to_km"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delivery_times", force: :cascade do |t|
    t.integer "time"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "delivery_distance_id", null: false
    t.index ["carrier_id"], name: "index_delivery_times_on_carrier_id"
    t.index ["delivery_distance_id"], name: "index_delivery_times_on_delivery_distance_id"
  end

  create_table "distance_prices", force: :cascade do |t|
    t.decimal "km_price", precision: 12, scale: 2
    t.integer "carrier_id", null: false
    t.integer "price_range_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_distance_prices_on_carrier_id"
    t.index ["price_range_id"], name: "index_distance_prices_on_price_range_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "order_number"
    t.decimal "order_value"
    t.integer "distance"
    t.date "delivery_date"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "package_volume"
    t.decimal "package_weight"
    t.string "origin_address"
    t.integer "status", default: 0
    t.string "destiny_address"
    t.index ["carrier_id"], name: "index_orders_on_carrier_id"
  end

  create_table "price_ranges", force: :cascade do |t|
    t.decimal "volume_start", precision: 12, scale: 2
    t.decimal "volume_end", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "weight_start", precision: 12, scale: 2
    t.decimal "weight_end", precision: 12, scale: 2
  end

  create_table "tracking_logs", force: :cascade do |t|
    t.string "what"
    t.string "where"
    t.datetime "when"
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_tracking_logs_on_order_id"
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
    t.integer "carrier_id", null: false
    t.index ["carrier_id"], name: "index_users_on_carrier_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "model"
    t.string "brand"
    t.string "license_plate"
    t.integer "year"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_vehicles_on_carrier_id"
  end

  add_foreign_key "delivery_times", "carriers"
  add_foreign_key "delivery_times", "delivery_distances"
  add_foreign_key "distance_prices", "carriers"
  add_foreign_key "distance_prices", "price_ranges"
  add_foreign_key "orders", "carriers"
  add_foreign_key "tracking_logs", "orders"
  add_foreign_key "users", "carriers"
  add_foreign_key "vehicles", "carriers"
end
