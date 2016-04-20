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

ActiveRecord::Schema.define(version: 20160420031826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clinics", force: true do |t|
    t.string "name"
    t.string "street_address", null: false
    t.string "city",           null: false
    t.string "zip",            null: false
    t.string "phone",          null: false
    t.string "website"
  end

  create_table "insurers", force: true do |t|
    t.string   "name",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_medicaid"
  end

  create_table "provider_insurers", force: true do |t|
    t.integer  "provider_id", null: false
    t.integer  "insurer_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", force: true do |t|
    t.string   "name",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "clinic_id",                 null: false
    t.string   "email"
    t.string   "type"
    t.string   "population_expertise"
    t.string   "specialization"
    t.string   "gender_id"
    t.string   "orientation"
    t.boolean  "comprehensive_intake"
    t.boolean  "use_pref_name"
    t.string   "trans_standard_of_care"
    t.boolean  "gender_neutral_rr"
    t.boolean  "lgbtq_trained"
    t.text     "lgbtq_training_details"
    t.boolean  "cultural_trained"
    t.text     "cultural_training_details"
    t.text     "lgbq_incl_strategy"
    t.text     "trans_incl_strategy"
    t.boolean  "new_clients"
    t.text     "community_relationship"
    t.text     "additional"
    t.string   "icon"
  end

  create_table "users", force: true do |t|
    t.string   "role",                   default: "User"
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
