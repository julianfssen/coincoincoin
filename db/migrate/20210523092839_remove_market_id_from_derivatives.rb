class RemoveMarketIdFromDerivatives < ActiveRecord::Migration[6.0]
  def change
    remove_column :derivatives, :market_id
  end
end
