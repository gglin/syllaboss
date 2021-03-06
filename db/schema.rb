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

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20130808163531) do
=======
ActiveRecord::Schema.define(:version => 20130817154642) do
>>>>>>> f94526cd6f73ec6da1960384bbfd05517fc03b9c

  create_table "abilities", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "attachments", :force => true do |t|
    t.string   "title"
    t.string   "filename"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "attachments", ["attachable_id", "attachable_type"], :name => "index_attachments_on_attachable_id_and_attachable_type"

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"

  create_table "homeworks", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "labs", :force => true do |t|
    t.string   "name"
    t.string   "lab_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lectures", :force => true do |t|
    t.integer  "creator"
    t.string   "title"
    t.text     "content"
    t.string   "file_upload"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "links", :force => true do |t|
    t.string   "title"
    t.string   "link_url"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "potds", :force => true do |t|
    t.string   "name"
    t.string   "wikipedia"
    t.string   "presentation_url"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "bio"
  end

  create_table "read_marks", :force => true do |t|
    t.integer  "readable_id"
    t.integer  "user_id",                     :null => false
    t.string   "readable_type", :limit => 20, :null => false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["user_id", "readable_type", "readable_id"], :name => "index_read_marks_on_user_id_and_readable_type_and_readable_id"

  create_table "school_day_homeworks", :force => true do |t|
    t.integer  "school_day_id"
    t.integer  "homework_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "school_day_labs", :force => true do |t|
    t.integer  "school_day_id"
    t.integer  "lab_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "school_day_lectures", :force => true do |t|
    t.integer  "school_day_id"
    t.integer  "lecture_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "school_day_links", :force => true do |t|
    t.integer  "school_day_id"
    t.integer  "link_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "school_day_todos", :force => true do |t|
    t.integer  "todo_id"
    t.integer  "school_day_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "school_days", :force => true do |t|
    t.integer  "ordinal"
    t.date     "calendar_date"
    t.text     "schedule"
    t.integer  "week"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "potd_id"
  end

  create_table "todos", :force => true do |t|
    t.string   "name"
    t.string   "gist"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
<<<<<<< HEAD
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
=======
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
>>>>>>> f94526cd6f73ec6da1960384bbfd05517fc03b9c
    t.integer  "role"
    t.string   "full_name"
    t.string   "username"
    t.string   "image"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "twitter"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
