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

ActiveRecord::Schema.define(version: 20181202112210) do

  create_table "areas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hexagons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "points", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.integer  "evaluate_user_id"
    t.integer  "hexagon_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["evaluate_user_id"], name: "index_points_on_evaluate_user_id", using: :btree
    t.index ["hexagon_id"], name: "index_points_on_hexagon_id", using: :btree
    t.index ["post_id"], name: "index_points_on_post_id", using: :btree
    t.index ["user_id"], name: "index_points_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "sports"
    t.string   "title"
    t.text     "content",     limit: 65535
    t.date     "event_date"
    t.time     "open"
    t.time     "closed"
    t.date     "due_date"
    t.time     "due_time"
    t.integer  "area_id"
    t.string   "place"
    t.integer  "capacity"
    t.integer  "cost"
    t.string   "level"
    t.integer  "age_minimum"
    t.integer  "age_maximum"
    t.string   "sex"
    t.integer  "reserve",                   default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["area_id"], name: "index_posts_on_area_id", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "icon"
    t.string   "active_area"
    t.string   "sex"
    t.date     "birthday"
    t.string   "sports"
    t.string   "level"
    t.string   "level_maximum"
    t.text     "battle_record", limit: 65535
    t.text     "career",        limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["post_id"], name: "index_relationships_on_post_id", using: :btree
    t.index ["user_id", "post_id"], name: "index_relationships_on_user_id_and_post_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_relationships_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "state",           default: 1
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "points", "hexagons"
  add_foreign_key "points", "posts"
  add_foreign_key "points", "users"
  add_foreign_key "points", "users", column: "evaluate_user_id"
  add_foreign_key "posts", "areas"
  add_foreign_key "profiles", "users"
  add_foreign_key "relationships", "posts"
  add_foreign_key "relationships", "users"
end
