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


ActiveRecord::Schema.define(:version => 20131114124051) do

  create_table "admincontacts", :force => true do |t|
    t.string   "emailid"
    t.string   "carmake"
    t.string   "carmodel"
    t.string   "enginedis"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end


ActiveRecord::Schema.define(:version => 20131112190717) do


  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "blogs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "car_makes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "car_models", :force => true do |t|
    t.string   "name"
    t.integer  "car_make_id"
    t.string   "engine_displacement"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end


  create_table "carprofile_photos", :force => true do |t|
    t.integer  "carprofile_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "carprofiles", :force => true do |t|
    t.integer  "car_make_id"
    t.integer  "car_model_id"
    t.date     "manufacturing_year"
    t.date     "year_of_purchase"
    t.string   "whatkindofcar"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "car_description"
    t.string   "power"
    t.string   "sellthiscar"
    t.string   "license_plate"
    t.string   "VIN"
    t.integer  "user_id"
    t.integer  "engine_id"
    t.integer  "carprofile_photo_id"

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false

  end

  create_table "contacts", :force => true do |t|
    t.string   "email"
    t.text     "message"
    t.string   "name"
    t.string   "subject"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "credits", :force => true do |t|
    t.integer  "credit"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "free_credit"
  end

  create_table "egifts", :force => true do |t|
    t.string   "credit"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "engines", :force => true do |t|
    t.integer  "car_model_id"
    t.string   "engine_displacement"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "logbook_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "meta_title"
    t.text     "meta_description"
    t.text     "meta_keyword"
  end

  create_table "seos", :force => true do |t|
    t.string   "meta_title"
    t.text     "meta_description"
    t.text     "meta_keyword"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.date     "birthday"
    t.string   "location"
    t.boolean  "agree"
    t.boolean  "status"
    t.integer  "credit",                 :default => 0,  :null => false
    t.integer  "freecredit",             :default => 0,  :null => false
    t.integer  "buycredit",              :default => 0,  :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
