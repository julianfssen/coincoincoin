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

ActiveRecord::Schema.define(version: 2021_05_22_104929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coins", force: :cascade do |t|
    t.string "name"
    t.string "ticker"
    t.decimal "last"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "derivative_daily_historical_prices", force: :cascade do |t|
    t.integer "derivative_id"
    t.integer "derivative_exchange_id"
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "derivative_exchanges", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.string "url"
    t.decimal "trade_volume_24h"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "coingecko_exchange_id"
  end

  create_table "derivatives", force: :cascade do |t|
    t.string "symbol"
    t.string "index_id"
    t.decimal "price"
    t.decimal "price_percentage_change_24h"
    t.string "contract_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "market_id"
    t.string "base"
    t.string "target"
    t.string "url"
    t.integer "last_updated"
    t.boolean "expired"
    t.decimal "funding_rate"
    t.decimal "bid_ask_spread"
    t.decimal "open_interest"
    t.decimal "volume_24h"
    t.integer "expiring_at"
  end

end
