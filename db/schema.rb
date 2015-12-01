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

ActiveRecord::Schema.define(version: 20151201063629) do

  create_table "metals", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "gemstone",   limit: 255
    t.integer  "price",      limit: 4,   default: 0
    t.integer  "product_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "metals", ["product_id"], name: "fk_rails_86a9e899f4", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "prod_id",      limit: 255
    t.string   "product_type", limit: 255
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "status",       limit: 255, default: "unfilled"
  end

  create_table "shops", force: :cascade do |t|
    t.string   "url",        limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "username",               limit: 255, default: "", null: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.datetime "birthdate"
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "variants", force: :cascade do |t|
    t.string   "metal_title", limit: 255, default: "", null: false
    t.string   "metal_price", limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "variants", ["metal_title"], name: "index_variants_on_metal_title", unique: true, using: :btree

  add_foreign_key "metals", "products"
end
