class AddCurrencyToNews < ActiveRecord::Migration[6.1]
  def change
    add_column :news, :currency, :string
  end
end
