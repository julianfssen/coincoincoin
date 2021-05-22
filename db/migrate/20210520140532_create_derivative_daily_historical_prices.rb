class CreateDerivativeDailyHistoricalPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :derivative_daily_historical_prices do |t|
      t.integer :derivative_id
      t.integer :derivative_exchange_id
      t.decimal :price

      t.timestamps
    end
  end
end
