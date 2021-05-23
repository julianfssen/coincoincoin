class AddOpenInterestToDerivativeExchange < ActiveRecord::Migration[6.0]
  def change
    add_column :derivative_exchanges, :open_interest, :decimal
  end
end
