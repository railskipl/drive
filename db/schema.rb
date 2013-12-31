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

ActiveRecord::Schema.define(:version => 20131231052823) do

  create_table "admincontacts", :force => true do |t|
    t.string   "emailid"
    t.string   "carmake"
    t.string   "carmodel"
    t.string   "enginedis"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  create_table "blocks", :force => true do |t|
    t.integer  "blocker_id"
    t.integer  "blockable_id"
    t.string   "blocker_type"
    t.string   "blockable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "blocks", ["blocker_id", "blockable_id", "blocker_type", "blockable_type"], :name => "IUSR_BLOCK"

  create_table "blog_comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_blog_id"
    t.text     "body"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "user_blog_user_id"
  end

  create_table "blogs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "body_indices", :force => true do |t|
    t.integer  "car_model_id"
    t.string   "bodyindex"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "manufacturing_year"
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
    t.string   "manufacturing_year"
    t.string   "year_of_purchase"
    t.string   "whatkindofcar"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "car_description"
    t.string   "power"
    t.string   "sellthiscar"
    t.string   "license_plate"
    t.string   "VIN"
    t.integer  "user_id"
    t.integer  "engine_id"
    t.integer  "carprofile_photo_id"
    t.integer  "body_index_id"
    t.boolean  "spotlighted",         :default => false
    t.string   "engine_dis"
    t.integer  "user_visit",          :default => 0
    t.integer  "comments_count",      :default => 0
  end

  create_table "comment_logbooks", :force => true do |t|
    t.integer  "logbook_id"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "logbook_user_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.text     "body"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "commentable_type"
    t.integer  "user_id"
    t.integer  "carprofile_id"
  end

  add_index "comments", ["commentable_id", "user_id"], :name => "index_comments_on_commentable_id_and_user_id"

  create_table "contacts", :force => true do |t|
    t.string   "email"
    t.text     "message"
    t.string   "name"
    t.string   "subject"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "credit_packages", :force => true do |t|
    t.string   "name"
    t.string   "package_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "credits", :force => true do |t|
    t.integer  "credit"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "free_credit"
  end

  create_table "egift_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "egifts", :force => true do |t|
    t.integer  "credit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "egift_category_id"
  end

  create_table "engines", :force => true do |t|
    t.integer  "car_model_id"
    t.string   "engine_displacement"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "favourites", :force => true do |t|
    t.integer  "user_id"
    t.string   "favourite_type"
    t.integer  "favourite_type_id"
    t.boolean  "is_read",           :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "user_blog_id"
    t.integer  "logbook_id"
    t.integer  "carprofile_id"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "accepted_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "flag"
  end

  create_table "impressions", :force => true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], :name => "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], :name => "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], :name => "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], :name => "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], :name => "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], :name => "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], :name => "impressionable_type_message_index"
  add_index "impressions", ["user_id"], :name => "index_impressions_on_user_id"

  create_table "likes", :force => true do |t|
    t.string   "liker_type"
    t.integer  "liker_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at"
    t.integer  "count",         :default => 0, :null => false
  end

  add_index "likes", ["likeable_id", "likeable_type"], :name => "fk_likeables"
  add_index "likes", ["liker_id", "liker_type"], :name => "fk_likes"

  create_table "logbook_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "logbooks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "logbook_category_id"
    t.integer  "car_make_id"
    t.integer  "car_model_id"
    t.integer  "body_index_id"
    t.text     "logbook_discription"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "carprofile_id"
    t.string   "title"
  end

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.boolean  "is_read",                 :default => false
    t.boolean  "is_deleted_by_sender",    :default => false
    t.boolean  "is_deleted_by_recipient", :default => false
    t.boolean  "is_trashed_by_recipient", :default => false
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "message_id"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.string   "notification_type"
    t.integer  "notifiable_id"
    t.boolean  "is_read",           :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "receiver_id"
    t.string   "rate_count"
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

  create_table "send_gifts", :force => true do |t|
    t.integer  "egift_id"
    t.text     "message"
    t.integer  "carprofile_id"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "visibility_id"
    t.boolean  "status",        :default => false
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

  create_table "subscribers", :force => true do |t|
    t.string   "subscriber_type"
    t.integer  "subscriber_id"
    t.string   "subscribable_type"
    t.integer  "subscribable_id"
    t.datetime "created_at"
  end

  add_index "subscribers", ["subscribable_id", "subscribable_type"], :name => "sk_subscribable"
  add_index "subscribers", ["subscriber_id", "subscriber_type"], :name => "sk_subscribers"

  create_table "user_blogs", :force => true do |t|
    t.integer  "blog_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "title"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",                    :null => false
    t.string   "encrypted_password",     :default => "",                    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,                     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.date     "birthday"
    t.string   "location"
    t.boolean  "agree"
    t.boolean  "status"
    t.integer  "credit",                 :default => 0,                     :null => false
    t.integer  "freecredit",             :default => 0,                     :null => false
    t.integer  "buycredit",              :default => 0,                     :null => false
    t.integer  "spend_credit",           :default => 0,                     :null => false
    t.text     "about"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.boolean  "visibility_status",      :default => true
    t.datetime "visibility_updated_on",  :default => '2013-12-10 08:10:34'
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "visibilities", :force => true do |t|
    t.string   "profile_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
