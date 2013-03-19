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

ActiveRecord::Schema.define(:version => 20130314193951) do

  create_table "employees", :force => true do |t|
    t.boolean  "contractor"
    t.boolean  "part_time_status"
    t.string   "full_name"
    t.string   "job_title"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "level"
    t.string   "cost_center"
  end

  create_table "group_associations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "type"
    t.integer  "source_id"
    t.integer  "sink_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "group_memberships", :force => true do |t|
    t.text     "description"
    t.string   "type"
    t.integer  "group_id"
    t.integer  "person_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "milestones", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "business_driver"
    t.string   "status"
    t.string   "health"
    t.date     "planned_start"
    t.date     "planned_finish"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "plan_id"
    t.string   "facing"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "ancestry"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "label"
    t.string   "controller_name"
    t.string   "action_name"
  end

  add_index "pages", ["ancestry"], :name => "index_pages_on_ancestry"

  create_table "parts", :force => true do |t|
    t.string   "commenter"
    t.text     "description"
    t.integer  "widget_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "parts", ["widget_id"], :name => "index_parts_on_widget_id"

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "person_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "temporary"
    t.string   "hr_status"
    t.boolean  "part_time"
    t.string   "band"
    t.string   "cost_center"
    t.string   "business_unit"
    t.string   "hiring_status"
  end

  create_table "person_associations", :force => true do |t|
    t.text     "description"
    t.string   "association_type"
    t.integer  "source_id"
    t.integer  "sink_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "portfolio_category"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "portfolio_id"
  end

  create_table "portfolios", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "reporting_relationships", :force => true do |t|
    t.integer  "subordinate_id"
    t.integer  "supervisor_id"
    t.boolean  "dotted",         :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "reporting_relationships", ["subordinate_id", "supervisor_id"], :name => "idx_subordinate_and_supervisor_id"
  add_index "reporting_relationships", ["supervisor_id"], :name => "idx_supervisor_id"

  create_table "resource_allocations", :force => true do |t|
    t.string   "comment"
    t.decimal  "quantity",     :precision => 10, :scale => 0
    t.integer  "milestone_id"
    t.integer  "person_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "widgets", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_foreign_key "parts", "widgets", :name => "parts_widget_id_fk"

end
