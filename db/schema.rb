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

ActiveRecord::Schema.define(version: 20180120093955) do

  create_table "lines", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "pipe_line_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pipe_line_id"], name: "index_lines_on_pipe_line_id"
  end

  create_table "marks", force: :cascade do |t|
    t.integer "index_mark"
    t.string "lat"
    t.string "lng"
    t.string "height"
    t.integer "line_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_id"], name: "index_marks_on_line_id"
  end

  create_table "pipe_lines", force: :cascade do |t|
    t.string "name"
    t.float "size_safe"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "township_lines", force: :cascade do |t|
    t.integer "line_id"
    t.integer "township_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_id"], name: "index_township_lines_on_line_id"
    t.index ["township_id"], name: "index_township_lines_on_township_id"
  end

  create_table "townships", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
