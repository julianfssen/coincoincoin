class AddCoingeckoExchangeIdToDerivativeExchanges < ActiveRecord::Migration[6.0]
  def change
    add_column :derivative_exchanges, :coingecko_exchange_id, :string
  end
end
