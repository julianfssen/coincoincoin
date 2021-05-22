class AddMoreAttributesToDerivatives < ActiveRecord::Migration[6.0]
  def change
    add_column :derivatives, :target, :string
    add_column :derivatives, :url, :string
    add_column :derivatives, :last_updated, :integer
    add_column :derivatives, :expired, :boolean
    add_column :derivatives, :funding_rate, :decimal
    add_column :derivatives, :bid_ask_spread, :decimal
    add_column :derivatives, :open_interest, :decimal
  end
end
