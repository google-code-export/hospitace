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

ActiveRecord::Schema.define(:version => 20120421195516) do

  create_table "attachments", :force => true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.binary   "data",          :limit => 16777215
    t.integer  "people_id",     :limit => 8
    t.integer  "evaluation_id"
    t.integer  "form_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "attachments", ["evaluation_id"], :name => "index_attachments_on_evaluation_id"
  add_index "attachments", ["form_id"], :name => "index_attachments_on_form_id"
  add_index "attachments", ["people_id"], :name => "index_attachments_on_people_id"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "course_instances", :force => true do |t|
    t.integer  "capacity"
    t.integer  "occupied"
    t.integer  "semester_id"
    t.integer  "course_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "classes_type"
    t.string   "range"
    t.string   "semester_season"
    t.string   "study_form"
    t.string   "code"
    t.string   "status"
    t.string   "completion"
    t.string   "credits"
    t.string   "description"
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "email_templates", :force => true do |t|
    t.string   "subject"
    t.text     "text"
    t.string   "form_code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "entries", :force => true do |t|
    t.text     "value"
    t.integer  "entry_id"
    t.integer  "form_id"
    t.integer  "entry_template_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "entries", ["entry_id"], :name => "index_entries_on_entry_id"
  add_index "entries", ["entry_template_id"], :name => "index_entries_on_entry_template_id"
  add_index "entries", ["form_id"], :name => "index_entries_on_form_id"

  create_table "entry_templates", :force => true do |t|
    t.integer  "form_template_id"
    t.boolean  "required"
    t.string   "label"
    t.string   "default"
    t.string   "item_type"
    t.integer  "template_order"
    t.integer  "entry_template_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "entry_templates", ["entry_template_id"], :name => "index_entry_templates_on_entry_template_id"
  add_index "entry_templates", ["form_template_id"], :name => "index_entry_templates_on_form_template_id"

  create_table "evaluations", :force => true do |t|
    t.integer  "observation_id"
    t.integer  "teacher_id",           :limit => 8
    t.string   "course"
    t.integer  "guarant_id",           :limit => 8
    t.string   "room"
    t.datetime "datetime_observation"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "form_templates", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.boolean  "required"
    t.string   "count"
    t.integer  "roles_mask"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "forms", :force => true do |t|
    t.integer  "people_id",        :limit => 8
    t.integer  "form_template_id"
    t.integer  "evaluation_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "forms", ["evaluation_id"], :name => "index_forms_on_evaluation_id"
  add_index "forms", ["form_template_id"], :name => "index_forms_on_form_template_id"
  add_index "forms", ["people_id"], :name => "index_forms_on_people_id"

  create_table "notes", :force => true do |t|
    t.text     "note"
    t.integer  "people_id",      :limit => 8
    t.integer  "observation_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "observations", :force => true do |t|
    t.integer  "created_by",            :limit => 8
    t.integer  "course_id"
    t.integer  "semester_id"
    t.integer  "parallel_id"
    t.date     "date"
    t.string   "observation_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "head_of_department_id", :limit => 8
  end

  create_table "observers", :force => true do |t|
    t.integer  "people_id",      :limit => 8
    t.integer  "observation_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "parallels", :force => true do |t|
    t.string   "day"
    t.integer  "first_hour"
    t.integer  "last_hour"
    t.string   "number"
    t.string   "parity"
    t.string   "parallel_type"
    t.integer  "room_id"
    t.integer  "course_instance_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.string   "title_pre"
    t.string   "title_post"
    t.boolean  "student"
    t.boolean  "teacher"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "peoples_relateds", :force => true do |t|
    t.integer  "related_id"
    t.string   "related_type"
    t.string   "relation"
    t.integer  "people_id",    :limit => 8
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "roles", :force => true do |t|
    t.integer  "roles_mask"
    t.integer  "people_id",  :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "semesters", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
