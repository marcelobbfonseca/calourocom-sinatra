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

ActiveRecord::Schema.define(version: 2019_01_19_134413) do

  create_table "answers", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "relevance"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["post_id"], name: "index_answers_on_post_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "description"
    t.integer "relevance"
    t.string "answer_type"
    t.integer "answer_id"
    t.string "post_type"
    t.integer "post_id"
    t.index ["answer_type", "answer_id"], name: "index_comments_on_answer_type_and_answer_id"
    t.index ["post_type", "post_id"], name: "index_comments_on_post_type_and_post_id"
  end

  create_table "institutes", force: :cascade do |t|
    t.integer "category"
    t.string "name"
    t.string "description"
    t.string "image_file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "relevance"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "posts_tags", force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
    t.index ["post_id"], name: "index_posts_tags_on_post_id"
    t.index ["tag_id"], name: "index_posts_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "wallet"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
