class CreateDerivativeExchanges < ActiveRecord::Migration[6.0]
  def change
    create_table :derivative_exchanges do |t|
      t.string :name
      t.string :image_url
      t.string :url
      t.decimal :trade_volume_24h

      t.timestamps
    end
  end
end
