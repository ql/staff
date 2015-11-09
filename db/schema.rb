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
    t.integer "skill_id"
    t.integer "applicant_id"
  end

  add_index "applicant_skills", ["skill_id", "applicant_id"], name: "index_applicant_skills_on_skill_id_and_applicant_id", unique: true, using: :btree

  create_table "applicants", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.float    "salary"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "position_skills", force: :cascade do |t|
    t.integer "skill_id"
    t.integer "position_id"
  end

  add_index "position_skills", ["skill_id", "position_id"], name: "index_position_skills_on_skill_id_and_position_id", unique: true, using: :btree

  create_table "positions", force: :cascade do |t|
    t.string   "name"
    t.date     "expires_at"
    t.float    "salary"
    t.text     "contacts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "skills", ["name"], name: "index_skills_on_name", unique: true, using: :btree

end
