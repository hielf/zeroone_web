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

ActiveRecord::Schema.define(version: 20161121172810) do

  create_table "admins", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "carousels", force: :cascade do |t|
    t.string   "first",      limit: 255
    t.string   "second",     limit: 2000
    t.string   "third",      limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "cell_codes", force: :cascade do |t|
    t.string   "cell",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "newbonus", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.decimal  "bonus",                    precision: 12, scale: 2, default: 0.0
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.integer  "subordinate_id", limit: 4
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.decimal  "prize",                    precision: 12, scale: 2, default: 0.0
    t.string   "image",        limit: 255
    t.string   "desc",         limit: 255
    t.string   "url",          limit: 255
    t.string   "status",       limit: 255
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.boolean  "recommend"
    t.decimal  "ratio",                    precision: 12, scale: 2, default: 0.0
    t.decimal  "bonus",                    precision: 12, scale: 2, default: 0.0
    t.integer  "user_id",      limit: 4
    t.string   "product_type", limit: 255
  end

  create_table "records", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "product_id",    limit: 4
    t.date     "sell_date"
    t.decimal  "qty",                       precision: 12, scale: 2, default: 0.0
    t.decimal  "total_prize",               precision: 12, scale: 2, default: 0.0
    t.string   "customer_name", limit: 255
    t.string   "customer_cell", limit: 255
    t.string   "status",        limit: 255
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.decimal  "total_insured",             precision: 12, scale: 2, default: 0.0
    t.date     "start_date"
    t.date     "end_date"
    t.string   "policy_no",     limit: 255
    t.decimal  "bonus",                     precision: 12, scale: 2, default: 0.0
    t.decimal  "commis",                    precision: 12, scale: 2, default: 0.0
  end

  create_table "users", force: :cascade do |t|
    t.string   "openid",            limit: 255
    t.string   "avatar",            limit: 255
    t.string   "number",            limit: 255
    t.string   "name",              limit: 255
    t.string   "cell",              limit: 255
    t.string   "email",             limit: 255
    t.string   "id_card",           limit: 255
    t.string   "bank_card",         limit: 255
    t.string   "alipay",            limit: 255
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
    t.string   "qrcode",            limit: 255
    t.integer  "superior_id",       limit: 4
    t.decimal  "commission",                    precision: 12, scale: 2, default: 0.0
    t.decimal  "second_commission",             precision: 12, scale: 2, default: 0.0
    t.decimal  "third_commission",              precision: 12, scale: 2, default: 0.0
    t.decimal  "balance",                       precision: 12, scale: 2, default: 0.0
    t.string   "channel",           limit: 255,                          default: "001"
    t.string   "password_digest",   limit: 255
    t.string   "token",             limit: 255
    t.string   "status",            limit: 255
    t.string   "user_type",         limit: 255,                          default: "normal"
    t.string   "bank",              limit: 255
  end

end
