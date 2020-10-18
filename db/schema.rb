# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_05_140744) do

  create_table "answers", force: :cascade do |t|
    t.text "description"
    t.integer "relevance", default: 0
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["post_id"], name: "index_answers_on_post_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "description"
    t.integer "relevance", default: 0
    t.string "commentable_type"
    t.integer "commentable_id"
    t.integer "user_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
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
    t.text "description"
    t.integer "relevance", default: 0
    t.integer "views", default: 0
    t.integer "user_id"
    t.integer "institute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["institute_id"], name: "index_posts_on_institute_id"
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
    t.string "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "calourocom@3896"
    t.string "email"
    t.string "avatar", default: "/img/anonymous-female-icon-16.png"
    t.integer "points", default: 0
    t.string "wallet"
    t.integer "institute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "role"
    t.index ["institute_id"], name: "index_users_on_institute_id"
  end

  add_foreign_key "answers", "posts"
  add_foreign_key "answers", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "posts", "institutes"
  add_foreign_key "posts", "users"
  add_foreign_key "posts_tags", "posts"
  add_foreign_key "posts_tags", "tags"
  add_foreign_key "users", "institutes"
end
