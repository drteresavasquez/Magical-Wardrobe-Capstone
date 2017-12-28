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

ActiveRecord::Schema.define(version: 20171228193307) do

  create_table "accessories", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "description"
    t.integer "weather_type_id"
    t.integer "accessory_type_id"
    t.integer "style_type_id"
    t.boolean "favorite"
    t.string "picture"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "temperature_type_id"
    t.integer "wearer_id"
    t.integer "item_id"
    t.index ["accessory_type_id"], name: "index_accessories_on_accessory_type_id"
    t.index ["style_type_id"], name: "index_accessories_on_style_type_id"
    t.index ["temperature_type_id"], name: "index_accessories_on_temperature_type_id"
    t.index ["user_id"], name: "index_accessories_on_user_id"
    t.index ["weather_type_id"], name: "index_accessories_on_weather_type_id"
  end

  create_table "accessory_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bottom_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bottoms", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "description"
    t.integer "weather_type_id"
    t.integer "bottom_type_id"
    t.integer "style_type_id"
    t.string "picture"
    t.boolean "favorite"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "temperature_type_id"
    t.integer "wearer_id"
    t.integer "item_id"
    t.index ["bottom_type_id"], name: "index_bottoms_on_bottom_type_id"
    t.index ["style_type_id"], name: "index_bottoms_on_style_type_id"
    t.index ["temperature_type_id"], name: "index_bottoms_on_temperature_type_id"
    t.index ["user_id"], name: "index_bottoms_on_user_id"
    t.index ["weather_type_id"], name: "index_bottoms_on_weather_type_id"
  end

  create_table "families", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "admin"
    t.integer "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "family_name"
    t.index ["user_id"], name: "index_families_on_user_id"
  end

  create_table "footwear_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "footwears", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "description"
    t.integer "weather_type_id"
    t.integer "footwear_type_id"
    t.integer "style_type_id"
    t.string "picture"
    t.boolean "favorite"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "temperature_type_id"
    t.integer "wearer_id"
    t.integer "item_id"
    t.index ["footwear_type_id"], name: "index_footwears_on_footwear_type_id"
    t.index ["style_type_id"], name: "index_footwears_on_style_type_id"
    t.index ["temperature_type_id"], name: "index_footwears_on_temperature_type_id"
    t.index ["user_id"], name: "index_footwears_on_user_id"
    t.index ["weather_type_id"], name: "index_footwears_on_weather_type_id"
  end

  create_table "outfits", force: :cascade do |t|
    t.integer "top_id"
    t.integer "bottom_id"
    t.integer "accessory_id"
    t.integer "footwear_id"
    t.integer "weather_type_id"
    t.integer "user_id"
    t.boolean "active"
    t.boolean "favorite"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "style_type_id"
    t.string "name"
    t.string "description"
    t.integer "temperature_type_id"
    t.integer "wearer_id"
    t.integer "item_id"
    t.index ["accessory_id"], name: "index_outfits_on_accessory_id"
    t.index ["bottom_id"], name: "index_outfits_on_bottom_id"
    t.index ["footwear_id"], name: "index_outfits_on_footwear_id"
    t.index ["style_type_id"], name: "index_outfits_on_style_type_id"
    t.index ["temperature_type_id"], name: "index_outfits_on_temperature_type_id"
    t.index ["top_id"], name: "index_outfits_on_top_id"
    t.index ["user_id"], name: "index_outfits_on_user_id"
    t.index ["weather_type_id"], name: "index_outfits_on_weather_type_id"
  end

  create_table "style_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "temperature_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "top_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tops", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.integer "weather_type_id"
    t.integer "top_type_id"
    t.integer "style_type_id"
    t.string "description"
    t.boolean "favorite"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.integer "temperature_type_id"
    t.integer "wearer_id"
    t.integer "item_id"
    t.index ["style_type_id"], name: "index_tops_on_style_type_id"
    t.index ["temperature_type_id"], name: "index_tops_on_temperature_type_id"
    t.index ["top_type_id"], name: "index_tops_on_top_type_id"
    t.index ["user_id"], name: "index_tops_on_user_id"
    t.index ["weather_type_id"], name: "index_tops_on_weather_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.integer "zip_code"
    t.string "password_digest"
    t.integer "family_id"
    t.boolean "family_admin"
    t.integer "wearer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "weather_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
