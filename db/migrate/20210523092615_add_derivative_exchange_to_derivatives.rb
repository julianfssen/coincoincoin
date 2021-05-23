class AddDerivativeExchangeToDerivatives < ActiveRecord::Migration[6.0]
  def change
    add_reference :derivatives, :derivative_exchange, null: true, foreign_key: true
  end
end
