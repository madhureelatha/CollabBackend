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

ActiveRecord::Schema.define(version: 2019_11_18_170244) do

  create_table "categories", primary_key: "category_id", force: :cascade do |t|
    t.string "category_name", limit: 45, null: false
    t.string "shortname", limit: 45
    t.string "sort_name", limit: 45
  end

  create_table "cities", primary_key: "city_id", force: :cascade do |t|
    t.string "city", limit: 45
    t.string "country", limit: 2
    t.decimal "distance", precision: 14, scale: 8
    t.decimal "latitude", precision: 14, scale: 8
    t.string "localized_country_name", limit: 45
    t.decimal "longitude", precision: 14, scale: 8
    t.integer "member_count", precision: 38
    t.integer "ranking", precision: 38
    t.string "state", limit: 2
    t.integer "zip", precision: 38
  end

  create_table "events", primary_key: "event_id", id: :string, limit: 75, force: :cascade do |t|
    t.date "created"
    t.text "description"
    t.integer "duration", precision: 38
    t.string "event_url", limit: 200
    t.string "event_name", limit: 100
    t.date "event_time"
    t.date "updated"
    t.integer "venue_id", precision: 38
    t.integer "group_id", precision: 38
    t.integer "yes_rsvp_count", precision: 38
  end

# Could not dump table "groups" because of following StandardError
#   Unknown type 'LONG' for column 'description'

  create_table "groups_topics", primary_key: ["topic_id", "group_id"], force: :cascade do |t|
    t.integer "topic_id", precision: 38, null: false
    t.string "topic_key", limit: 60
    t.string "topic_name", limit: 60
    t.integer "group_id", precision: 38, null: false
  end

  create_table "member_group", primary_key: ["member_id", "group_id"], force: :cascade do |t|
    t.integer "member_id", precision: 38, null: false
    t.integer "group_id", precision: 38, null: false
    t.date "joined"
    t.string "member_status", limit: 25
    t.date "visited"
  end

  create_table "member_topics", primary_key: ["topic_id", "member_id"], force: :cascade do |t|
    t.integer "topic_id", precision: 38, null: false
    t.string "topic_key", limit: 60
    t.string "topic_name", limit: 60
    t.integer "member_id", precision: 38, null: false
  end

  create_table "members", primary_key: "member_id", force: :cascade do |t|
    t.string "bio", limit: 499
    t.string "city", limit: 50
    t.string "country", limit: 2
    t.string "hometown", limit: 45
    t.decimal "lat", precision: 12, scale: 8
    t.string "link", limit: 200
    t.decimal "lon", precision: 12, scale: 8
    t.string "member_name", limit: 45, null: false
    t.string "state", limit: 2
    t.string "member_status", limit: 25
  end

  create_table "members2", id: false, force: :cascade do |t|
    t.integer "member_id", precision: 38
    t.string "bio", limit: 499
    t.string "city", limit: 50
    t.string "country", limit: 2
    t.string "hometown", limit: 45
    t.decimal "lat", precision: 12, scale: 8
    t.string "link", limit: 200
    t.decimal "lon", precision: 12, scale: 8
    t.string "member_name", limit: 45
    t.string "state", limit: 2
    t.string "member_status", limit: 25
    t.date "joined"
    t.date "visited"
    t.integer "group_id", precision: 38
  end

  create_table "posts", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "topics", primary_key: "topic_id", force: :cascade do |t|
    t.string "description", limit: 499
    t.string "link", limit: 99
    t.integer "members", precision: 38
    t.string "topic_name", limit: 99
    t.string "urlkey", limit: 99
    t.integer "main_topic_id", precision: 38, null: false
  end

  create_table "venues", primary_key: "venue_id", force: :cascade do |t|
    t.string "address_1", limit: 200
    t.string "city", limit: 45
    t.string "country", limit: 2
    t.decimal "lat", precision: 12, scale: 8
    t.string "localized_country_name", limit: 45
    t.decimal "lon", precision: 12, scale: 8
    t.string "venue_name", limit: 300
    t.decimal "rating", precision: 4, scale: 2
    t.integer "rating_count", precision: 38
    t.string "state", limit: 2
    t.integer "zip", precision: 38
    t.decimal "normalised_rating", precision: 4, scale: 2
  end

  add_foreign_key "events", "groups", primary_key: "group_id", name: "sys_c0048589"
  add_foreign_key "events", "venues", primary_key: "venue_id", name: "sys_c0048588"
  add_foreign_key "groups", "categories", primary_key: "category_id", name: "sys_c0023541"
  add_foreign_key "groups", "cities", primary_key: "city_id", name: "sys_c0023542"
  add_foreign_key "groups", "members", column: "organizer_member_id", primary_key: "member_id", name: "sys_c0023543"
  add_foreign_key "groups_topics", "groups", primary_key: "group_id", name: "sys_c0023552"
  add_foreign_key "groups_topics", "topics", primary_key: "topic_id", name: "sys_c0023551"
  add_foreign_key "member_group", "groups", primary_key: "group_id", name: "sys_c0023555"
  add_foreign_key "member_group", "members", primary_key: "member_id", name: "sys_c0023554"
  add_foreign_key "member_topics", "members", primary_key: "member_id", name: "sys_c0023528"
  add_foreign_key "member_topics", "topics", primary_key: "topic_id", name: "sys_c0023527"
end
