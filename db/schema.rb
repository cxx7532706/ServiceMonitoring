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

ActiveRecord::Schema.define(version: 20150915022818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "survey_id"
    t.integer  "question_id"
    t.integer  "client_ref"
    t.string   "content"
    t.integer  "feedback_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["feedback_id"], name: "index_answers_on_feedback_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.string   "reference_number"
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["survey_id"], name: "index_feedbacks_on_survey_id", using: :btree

  create_table "question_options", force: true do |t|
    t.string   "option"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "question_options", ["question_id"], name: "index_question_options_on_question_id", using: :btree

  create_table "questions", force: true do |t|
    t.string   "q_type"
    t.integer  "survey_id"
    t.string   "language"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id", using: :btree

  create_table "surveys", force: true do |t|
    t.string   "name"
    t.integer  "version"
    t.integer  "enable_flg"
    t.string   "provider_name"
    t.string   "language_avaliable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.boolean  "is_admin"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

end
