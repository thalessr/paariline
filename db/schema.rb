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

ActiveRecord::Schema.define(version: 2019_02_20_000216) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.string "description", null: false
    t.string "source_name", null: false
    t.integer "source_id", null: false
    t.string "icon"
    t.string "color"
    t.datetime "happened_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_activities_on_owner_id"
    t.index ["source_id"], name: "index_activities_on_source_id"
    t.index ["source_name"], name: "index_activities_on_source_name"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.integer "chat_room_id"
    t.integer "sent_by_id"
    t.integer "seen_by_id"
    t.text "content"
    t.datetime "seent_at"
    t.datetime "sent_at"
    t.index ["chat_room_id"], name: "index_chat_messages_on_chat_room_id"
    t.index ["seen_by_id"], name: "index_chat_messages_on_seen_by_id"
    t.index ["sent_by_id"], name: "index_chat_messages_on_sent_by_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.integer "participant_id", null: false
    t.integer "created_by_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_chat_rooms_on_created_by_id"
    t.index ["participant_id", "created_by_id"], name: "index_chat_rooms_on_participant_id_and_created_by_id", unique: true
    t.index ["participant_id"], name: "index_chat_rooms_on_participant_id"
  end

  create_table "picture_interactions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "profile_picture_id"
    t.string "interaction_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interaction_type"], name: "index_picture_interactions_on_interaction_type"
    t.index ["profile_picture_id"], name: "index_picture_interactions_on_profile_picture_id"
    t.index ["user_id"], name: "index_picture_interactions_on_user_id"
  end

  create_table "profile_pictures", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "dislike_count", default: 0
    t.integer "like_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profile_pictures_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.date "birth_date"
    t.string "first_name"
    t.string "last_name"
    t.string "city"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
