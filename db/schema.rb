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

ActiveRecord::Schema.define(version: 20170625162818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "card_tokens", force: :cascade do |t|
    t.uuid    "user_uuid"
    t.integer "stripe_customer_id"
    t.string  "card_token"
    t.integer "order_id"
    t.boolean "active",             default: true
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "product_variant_id"
    t.integer  "quantity"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
    t.index ["product_variant_id"], name: "index_cart_items_on_product_variant_id", using: :btree
  end

  create_table "carts", force: :cascade do |t|
    t.string   "cart_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid     "user_uuid"
    t.index ["cart_type"], name: "index_carts_on_cart_type", using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_variant_id"
    t.integer  "quantity"
    t.integer  "individual_price"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "shipping_id"
    t.string   "shipping_rate_id"
    t.string   "shipping_transaction_id"
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
    t.index ["product_variant_id"], name: "index_order_items_on_product_variant_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "status"
    t.integer  "total_price"
    t.uuid     "user_uuid"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "taxes_cents"
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "picture"
    t.integer  "product_variant_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["product_variant_id"], name: "index_pictures_on_product_variant_id", using: :btree
  end

  create_table "product_variants", force: :cascade do |t|
    t.string   "variation"
    t.integer  "product_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "price_cents"
    t.integer  "weight_pounds"
    t.integer  "weight_ounces"
    t.float    "height"
    t.float    "width"
    t.float    "length"
    t.index ["product_id"], name: "index_product_variants_on_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street_address_1"
    t.string   "street_address_2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "country",          default: "US"
    t.integer  "order_id"
    t.boolean  "remember"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["order_id"], name: "index_shipping_addresses_on_order_id", using: :btree
  end

  create_table "user_addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street_address_1"
    t.string   "street_address_2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_id"], name: "index_user_addresses_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "permission",        default: "end_user"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.uuid     "uuid",              default: -> { "uuid_generate_v4()" }
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "product_variants"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "product_variants"
  add_foreign_key "pictures", "product_variants"
  add_foreign_key "product_variants", "products"
  add_foreign_key "user_addresses", "users"
end
