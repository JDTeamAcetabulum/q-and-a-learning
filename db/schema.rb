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

ActiveRecord::Schema.define(version: 20170313020218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.boolean  "correct"
    t.string   "content"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "answers_users", id: false, force: :cascade do |t|
    t.integer "user_id",   null: false
    t.integer "answer_id", null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lecturetaggings", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "lecture_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["lecture_id"], name: "index_lecturetaggings_on_lecture_id", using: :btree
    t.index ["question_id"], name: "index_lecturetaggings_on_question_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "content"
    t.datetime "published_at"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topictaggings", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "topic_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_topictaggings_on_question_id", using: :btree
    t.index ["topic_id"], name: "index_topictaggings_on_topic_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "role"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "lecturetaggings", "lectures"
  add_foreign_key "lecturetaggings", "questions"
  add_foreign_key "topictaggings", "questions"
  add_foreign_key "topictaggings", "topics"
end
