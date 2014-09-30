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

ActiveRecord::Schema.define(version: 20140901011204) do

  create_table "action_colors", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "type_action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colors", force: true do |t|
    t.integer  "lamp_id"
    t.string   "lamp_name"
    t.string   "code_hex"
    t.string   "code_xy"
    t.integer  "saturation",      default: 0
    t.integer  "brightness",      default: 0
    t.boolean  "on",              default: true
    t.boolean  "alert",           default: false
    t.integer  "action_color_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
