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

ActiveRecord::Schema.define(:version => 20130511180835) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.index ["account_id"], :name => "fk__clients_account_id"
    t.index ["account_id"], :name => "index_clients_on_account_id"
    t.foreign_key ["account_id"], "accounts", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_clients_account_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "client_id",  :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.index ["client_id"], :name => "index_projects_on_client_id"
  end

  create_table "parts", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "account_id"
    t.index ["project_id"], :name => "fk__parts_project_id"
    t.index ["project_id"], :name => "index_parts_on_project_id"
    t.index ["account_id"], :name => "fk__parts_account_id"
    t.index ["account_id"], :name => "index_parts_on_account_id"
    t.foreign_key ["account_id"], "accounts", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_parts_account_id"
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_parts_project_id"
  end

  create_view "autocomplete_parts", "select concat(`c`.`name`,' - ',`pj`.`name`,' - ',`p`.`name`) AS `calculated_name`,`p`.`id` AS `part_id`,`c`.`account_id` AS `account_id` from ((`clients` `c` join `projects` `pj` on((`pj`.`client_id` = `c`.`id`))) join `parts` `p` on((`p`.`project_id` = `pj`.`id`)))", :force => true
  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "",         :null => false
    t.string   "name"
    t.integer  "account_id",                           :default => 0,          :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "theme",                                :default => "cerulean"
    t.index ["email"], :name => "index_users_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    t.index ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
    t.index ["account_id"], :name => "index_users_on_account_id"
  end

  create_table "partial_timelogs", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.datetime "last_resume_at"
    t.integer  "duration"
    t.string   "status",         :default => "initialized"
    t.index ["user_id"], :name => "fk__partial_timelogs_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_partial_timelogs_user_id"
  end

  create_table "timelogs", :force => true do |t|
    t.integer "part_id"
    t.integer "user_id"
    t.text    "name"
    t.integer "duration"
    t.date    "worked_on"
    t.index ["part_id"], :name => "fk__timelogs_part_id"
    t.index ["user_id"], :name => "fk__timelogs_user_id"
    t.index ["part_id"], :name => "index_timelogs_on_part_id"
    t.index ["user_id"], :name => "index_timelogs_on_user_id"
    t.foreign_key ["part_id"], "parts", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_timelogs_part_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_timelogs_user_id"
  end

end
