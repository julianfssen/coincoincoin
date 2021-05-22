class AddBaseToDerivatives < ActiveRecord::Migration[6.0]
  def change
    add_column :derivatives, :base, :string
  end
end
