

ActiveRecord::Schema.define(version: 6) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "customers", force: :cascade do |t|
    t.citext   "first_name"
    t.citext   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "invoice_id"
    t.integer  "quantity"
    t.integer  "unit_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id", using: :btree
    t.index ["item_id"], name: "index_invoice_items_on_item_id", using: :btree
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "merchant_id"
    t.citext   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["customer_id"], name: "index_invoices_on_customer_id", using: :btree
    t.index ["merchant_id"], name: "index_invoices_on_merchant_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.citext   "name"
    t.citext   "description"
    t.integer  "unit_price"
    t.integer  "merchant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["merchant_id"], name: "index_items_on_merchant_id", using: :btree
  end

  create_table "merchants", force: :cascade do |t|
    t.citext   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "invoice_id"
    t.text     "credit_card_number"
    t.text     "credit_card_expiration_date"
    t.citext   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["invoice_id"], name: "index_transactions_on_invoice_id", using: :btree
  end

  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoice_items", "items"
  add_foreign_key "invoices", "customers"
  add_foreign_key "invoices", "merchants"
  add_foreign_key "items", "merchants"
  add_foreign_key "transactions", "invoices"
end
