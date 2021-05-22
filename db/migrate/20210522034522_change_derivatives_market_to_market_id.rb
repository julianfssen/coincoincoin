class ChangeDerivativesMarketToMarketId < ActiveRecord::Migration[6.0]
  def change
    remove_column :derivatives, :market
    add_column :derivatives, :market_id, :integer
  end
end
