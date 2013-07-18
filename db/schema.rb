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

ActiveRecord::Schema.define(:version => 20130718213514) do

  create_table "homeworks", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
    t.text     "content"
  end

  create_table "labs", :force => true do |t|
    t.string   "name"
    t.string   "lab_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
  end

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

end
