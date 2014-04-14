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

ActiveRecord::Schema.define(:version => 20140414153319) do

  create_table "article_content_ratings", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "article_id"
    t.integer  "rating_01"
    t.integer  "rating_02"
    t.integer  "rating_03"
    t.integer  "rating_04"
    t.integer  "rating_05"
    t.string   "tag_01"
    t.string   "tag_02"
    t.string   "tag_03"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "article_ratings", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "article_id"
    t.integer  "rating_01"
    t.integer  "rating_02"
    t.integer  "rating_03"
    t.integer  "rating_04"
    t.integer  "rating_05"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "articles", :force => true do |t|
    t.string  "title"
    t.string  "url"
    t.integer "page_view_count"
    t.string  "source"
    t.integer "type_id"
    t.integer "within_type_id"
    t.string  "tweet_path"
    t.string  "content_path"
  end

  create_table "demographics", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "age"
    t.string   "state"
    t.integer  "topic_01"
    t.integer  "topic_02"
    t.integer  "topic_03"
    t.integer  "topic_04"
    t.integer  "site_01"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "topic_05"
    t.integer  "topic_06"
    t.integer  "topic_07"
    t.integer  "topic_08"
    t.integer  "topic_09"
    t.integer  "topic_10"
    t.string   "username"
  end

  create_table "participants", :force => true do |t|
    t.string   "worker_id"
    t.string   "hit_id"
    t.string   "assignment_id"
    t.integer  "condition"
    t.string   "article_within_type_id_array"
    t.string   "article_type_id_array"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "personalities", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "gender"
    t.integer  "big5_01"
    t.integer  "big5_02"
    t.integer  "big5_03"
    t.integer  "big5_04"
    t.integer  "big5_05"
    t.integer  "big5_06"
    t.integer  "big5_07"
    t.integer  "big5_08"
    t.integer  "big5_09"
    t.integer  "big5_10"
    t.integer  "big5_11"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "tweets", :force => true do |t|
    t.text     "text"
    t.integer  "favorites_count"
    t.integer  "retweet_count"
    t.datetime "time"
    t.string   "user_uid"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "twitter_checks", :force => true do |t|
    t.string   "user_name"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "token"
    t.string   "secret"
    t.integer  "participant_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "values", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "val_01"
    t.integer  "val_02"
    t.integer  "val_03"
    t.integer  "val_04"
    t.integer  "val_05"
    t.integer  "val_06"
    t.integer  "val_07"
    t.integer  "val_08"
    t.integer  "val_09"
    t.integer  "val_10"
    t.integer  "val_11"
    t.integer  "val_12"
    t.integer  "val_13"
    t.integer  "val_14"
    t.integer  "val_15"
    t.integer  "val_16"
    t.integer  "val_17"
    t.integer  "val_18"
    t.integer  "val_19"
    t.integer  "val_20"
    t.integer  "val_21"
    t.integer  "val_22"
    t.integer  "val_23"
    t.integer  "val_24"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
