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

ActiveRecord::Schema.define(version: 2020_09_20_215235) do

  create_table "albums", force: :cascade do |t|
    t.integer "artist_id"
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_albums_on_artist_id"
  end

# Could not dump table "albums_fts" because of following StandardError
#   Unknown type '' for column 'title'

  create_table "albums_fts_docsize", primary_key: "docid", force: :cascade do |t|
    t.binary "size"
  end

  create_table "albums_fts_segdir", primary_key: ["level", "idx"], force: :cascade do |t|
    t.integer "level"
    t.integer "idx"
    t.integer "start_block"
    t.integer "leaves_end_block"
    t.integer "end_block"
    t.binary "root"
  end

  create_table "albums_fts_segments", primary_key: "blockid", force: :cascade do |t|
    t.binary "block"
  end

  create_table "albums_fts_stat", force: :cascade do |t|
    t.binary "value"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

# Could not dump table "artists_fts" because of following StandardError
#   Unknown type '' for column 'name'

  create_table "artists_fts_docsize", primary_key: "docid", force: :cascade do |t|
    t.binary "size"
  end

  create_table "artists_fts_segdir", primary_key: ["level", "idx"], force: :cascade do |t|
    t.integer "level"
    t.integer "idx"
    t.integer "start_block"
    t.integer "leaves_end_block"
    t.integer "end_block"
    t.binary "root"
  end

  create_table "artists_fts_segments", primary_key: "blockid", force: :cascade do |t|
    t.binary "block"
  end

  create_table "artists_fts_stat", force: :cascade do |t|
    t.binary "value"
  end

  create_table "songs", force: :cascade do |t|
    t.integer "album_id"
    t.integer "artist_id"
    t.string "title", null: false
    t.integer "track_number"
    t.string "genre"
    t.integer "year"
    t.integer "length"
    t.integer "disc_number"
    t.string "folder"
    t.string "filename"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["album_id"], name: "index_songs_on_album_id"
    t.index ["artist_id"], name: "index_songs_on_artist_id"
  end

# Could not dump table "songs_fts" because of following StandardError
#   Unknown type '' for column 'title'

  create_table "songs_fts_docsize", primary_key: "docid", force: :cascade do |t|
    t.binary "size"
  end

  create_table "songs_fts_segdir", primary_key: ["level", "idx"], force: :cascade do |t|
    t.integer "level"
    t.integer "idx"
    t.integer "start_block"
    t.integer "leaves_end_block"
    t.integer "end_block"
    t.binary "root"
  end

  create_table "songs_fts_segments", primary_key: "blockid", force: :cascade do |t|
    t.binary "block"
  end

  create_table "songs_fts_stat", force: :cascade do |t|
    t.binary "value"
  end

end
