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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111108114055) do

  create_table "buildings", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.integer  "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.datetime "date"
    t.text     "text"
    t.string   "entity"
    t.integer  "entity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "final_reports", :force => true do |t|
    t.text     "text"
    t.datetime "created"
    t.integer  "observation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "final_reports", ["observation_id"], :name => "index_final_reports_on_observation_id"

  create_table "models", :force => true do |t|
    t.string   "attr1"
    t.string   "attr2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "observations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "week"
    t.integer  "paraller"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "announced"
    t.string   "course"
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "building_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rooms", ["building_id"], :name => "index_rooms_on_building_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tests", :force => true do |t|
    t.string   "shipping_name"
    t.string   "billing_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
