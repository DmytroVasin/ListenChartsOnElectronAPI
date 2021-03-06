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

ActiveRecord::Schema.define(version: 20140415201793) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "episodes", force: :cascade do |t|
    t.integer  "station_id"
    t.boolean  "in_top",          default: true, null: false
    t.string   "artist"
    t.string   "title"
    t.integer  "place"
    t.integer  "previous_place"
    t.integer  "sc_id"
    t.string   "sc_title"
    t.integer  "sc_duration"
    t.string   "sc_stream_url"
    t.string   "sc_image_url"
    t.string   "sc_download_url"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.text     "url"
    t.integer  "place"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
