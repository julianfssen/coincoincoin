class RemoveDecimalColumnFromDerivatives < ActiveRecord::Migration[6.0]
  def change
    remove_column :derivatives, :decimal
  end
end
