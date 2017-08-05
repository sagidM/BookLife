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

ActiveRecord::Schema.define(version: 20170731055423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abstract_books", force: :cascade do |t|
    t.string "original_name", limit: 50, null: false
    t.date "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["original_name"], name: "index_abstract_books_on_original_name"
  end

  create_table "abstract_books_authors", id: false, force: :cascade do |t|
    t.bigint "abstract_book_id", null: false
    t.bigint "author_id", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abstract_book_id", "author_id"], name: "index_abstract_books_authors_on_abstract_book_id_and_author_id", unique: true
  end

  create_table "abstract_books_book_series", id: false, force: :cascade do |t|
    t.bigint "abstract_book_id", null: false
    t.bigint "book_series_id", null: false
    t.index ["abstract_book_id", "book_series_id"], name: "unique_index_abstract_books__book_series", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "first_name", limit: 50, null: false
    t.string "surname", limit: 50, null: false
    t.string "patronymic", limit: 50
    t.string "avatar", limit: 255
    t.date "bdate"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name", "patronymic"], name: "index_authors_on_first_name_and_patronymic"
    t.index ["surname", "patronymic"], name: "index_authors_on_surname_and_patronymic"
    t.index ["user_id"], name: "index_authors_on_user_id", unique: true
  end

  create_table "book_series", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "poster", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_book_series_on_name"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "remember_token", limit: 255, null: false
    t.string "ip_address", limit: 39, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 50, null: false
    t.string "surname", limit: 50
    t.string "avatar", limit: 255
    t.date "bdate"
    t.string "email", limit: 64, null: false
    t.string "password_digest", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "abstract_books_authors", "abstract_books", on_delete: :cascade
  add_foreign_key "abstract_books_authors", "authors", on_delete: :cascade
  add_foreign_key "abstract_books_book_series", "abstract_books", on_delete: :cascade
  add_foreign_key "abstract_books_book_series", "book_series", on_delete: :cascade
  add_foreign_key "authors", "users", on_delete: :cascade
  add_foreign_key "sessions", "users", on_delete: :cascade
end
