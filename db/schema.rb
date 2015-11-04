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

ActiveRecord::Schema.define(version: 20151102171230) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicant_skills", force: :cascade do |t|
    t.string  "skillname"
    t.integer "skill_id"
    t.integer "applicant_id"
  end

  create_table "applicants", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "phone"
    t.string   "email"
    t.decimal  "salary"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "position_skills", force: :cascade do |t|
    t.string  "skillname"
    t.integer "skill_id"
    t.integer "position_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name"
    t.date     "expires_at"
    t.decimal  "salary"
    t.text     "contacts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
