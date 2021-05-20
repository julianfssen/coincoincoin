class CreateDerivatives < ActiveRecord::Migration[6.0]
  def change
    create_table :derivatives do |t|
      t.string :market
      t.string :symbol
      t.string :index_id
      t.decimal :price
      t.decimal :price_percentage_change_24h
      t.string :contract_type
      t.string :volume_24h
      t.string :decimal

      t.timestamps
    end
  end
end
