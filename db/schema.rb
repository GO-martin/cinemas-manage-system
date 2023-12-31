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

ActiveRecord::Schema[7.0].define(version: 2023_11_21_191324) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "showtime_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row_index", null: false
    t.integer "column_index", null: false
    t.bigint "user_id", null: false
    t.index ["showtime_id"], name: "index_bookings_on_showtime_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "cinemas", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_cinemas_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "director", null: false
    t.text "description"
    t.date "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "length"
    t.string "trailer"
    t.integer "status", default: 0
  end

  create_table "notifications", force: :cascade do |t|
    t.string "notifiable_type", null: false
    t.bigint "notifiable_id", null: false
    t.bigint "user_id", null: false
    t.boolean "viewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_role", default: 0
    t.integer "schedule", default: 0
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "fullname"
    t.date "birthday"
    t.text "address"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "number_of_seats"
    t.bigint "cinema_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row_size"
    t.integer "column_size"
    t.index ["cinema_id"], name: "index_rooms_on_cinema_id"
  end

  create_table "showtimes", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "start_time"
    t.integer "fare"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
    t.datetime "end_time"
    t.bigint "location_id", default: 2, null: false
    t.bigint "cinema_id"
    t.index ["cinema_id"], name: "index_showtimes_on_cinema_id"
    t.index ["location_id"], name: "index_showtimes_on_location_id"
    t.index ["movie_id"], name: "index_showtimes_on_movie_id"
    t.index ["room_id"], name: "index_showtimes_on_room_id"
  end

  create_table "structure_of_rooms", force: :cascade do |t|
    t.integer "row_index", null: false
    t.integer "column_index", null: false
    t.string "type_seat", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_structure_of_rooms_on_room_id"
  end

  create_table "supplies", force: :cascade do |t|
    t.integer "quantity"
    t.integer "price"
    t.string "name"
    t.bigint "cinema_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["cinema_id"], name: "index_supplies_on_cinema_id"
  end

  create_table "ticket_supplies", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.bigint "supply_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.index ["supply_id"], name: "index_ticket_supplies_on_supply_id"
    t.index ["ticket_id"], name: "index_ticket_supplies_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "seat_row", null: false
    t.integer "seat_column", null: false
    t.integer "price", null: false
    t.bigint "user_id", null: false
    t.bigint "showtime_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_payment_id"
    t.string "seat_name"
    t.index ["showtime_id"], name: "index_tickets_on_showtime_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "showtimes"
  add_foreign_key "bookings", "users"
  add_foreign_key "cinemas", "locations"
  add_foreign_key "notifications", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "rooms", "cinemas"
  add_foreign_key "showtimes", "cinemas"
  add_foreign_key "showtimes", "locations"
  add_foreign_key "showtimes", "movies"
  add_foreign_key "showtimes", "rooms"
  add_foreign_key "structure_of_rooms", "rooms"
  add_foreign_key "supplies", "cinemas"
  add_foreign_key "ticket_supplies", "supplies"
  add_foreign_key "ticket_supplies", "tickets"
  add_foreign_key "tickets", "showtimes"
  add_foreign_key "tickets", "users"
end
