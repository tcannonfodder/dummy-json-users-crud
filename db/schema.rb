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

ActiveRecord::Schema[7.0].define(version: 2023_04_05_150445) do
  create_table "users", force: :cascade do |t|
    t.integer "dummy_json_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "domain"
    t.string "ip_address"
    t.string "mac_address"
    t.text "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.integer "status", default: 0
    t.index ["dummy_json_id"], name: "index_users_on_dummy_json_id", unique: true
    t.index ["email"], name: "index_users_on_email"
  end

end
