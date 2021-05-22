class AddExpiringAtToDerivatives < ActiveRecord::Migration[6.0]
  def change
    add_column :derivatives, :expiring_at, :integer
  end
end
