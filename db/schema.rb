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

ActiveRecord::Schema.define(version: 2020_03_02_133632) do

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_departments_on_name", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 10, scale: 2
    t.integer "department_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_products_on_department_id"
  end

  create_table "products_promotions", id: false, force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "promotion_id", null: false
    t.index ["product_id", "promotion_id"], name: "index_products_promotions_on_product_id_and_promotion_id"
    t.index ["promotion_id", "product_id"], name: "index_products_promotions_on_promotion_id_and_product_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.decimal "discount", precision: 5, scale: 2
    t.boolean "active"
    t.string "code", limit: 5, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_promotions_on_code", unique: true
  end

  add_foreign_key "products", "departments"
end
