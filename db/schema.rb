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

ActiveRecord::Schema.define(version: 2017_04_05_124037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.string "name"
    t.decimal "initial_balance"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "credit_card_flags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "credit_card_flag_id"
    t.integer "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.decimal "limit"
    t.integer "closing_at"
    t.index ["credit_card_flag_id"], name: "index_credit_cards_on_credit_card_flag_id"
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "expenses", id: :serial, force: :cascade do |t|
    t.string "description"
    t.decimal "value"
    t.date "expensed_at"
    t.integer "credit_card_id"
    t.integer "category_id"
    t.date "payment_date"
    t.boolean "paid"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "form_of_payment"
    t.boolean "parceled"
    t.index ["category_id"], name: "index_expenses_on_category_id"
    t.index ["credit_card_id"], name: "index_expenses_on_credit_card_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "incomes", id: :serial, force: :cascade do |t|
    t.string "description"
    t.decimal "value"
    t.date "date"
    t.integer "category_id"
    t.boolean "received"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_incomes_on_category_id"
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "parcels", id: :serial, force: :cascade do |t|
    t.boolean "paid"
    t.integer "number"
    t.decimal "value"
    t.date "due_date"
    t.integer "expense_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_parcels_on_expense_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
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
    t.string "name", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "credit_cards", "credit_card_flags"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "expenses", "categories"
  add_foreign_key "expenses", "credit_cards"
  add_foreign_key "expenses", "users"
  add_foreign_key "incomes", "categories"
  add_foreign_key "incomes", "users"
  add_foreign_key "parcels", "expenses"
end
