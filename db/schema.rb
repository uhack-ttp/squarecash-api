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

ActiveRecord::Schema.define(version: 20171202064132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.money "balance", scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "name", null: false
    t.string "token", null: false
    t.datetime "expires_at", null: false
    t.text "domains", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "product_id"
    t.money "price", scale: 2
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_items_on_cart_id"
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "description"
    t.integer "quantity"
    t.string "picture"
    t.money "price", scale: 2
    t.string "type"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.bigint "store_admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_admin_id"], name: "index_stores_on_store_admin_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "store_id"
    t.money "total_price", scale: 2, default: "0.0"
    t.string "state"
    t.string "type"
    t.string "code"
    t.string "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_transactions_on_customer_id"
    t.index ["store_id"], name: "index_transactions_on_store_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "type"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
