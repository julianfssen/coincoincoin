class Change24HVolumeInDerivativesToDecimal < ActiveRecord::Migration[6.0]
  def change
    remove_column :derivatives, :volume_24h
    add_column :derivatives, :volume_24h, :decimal
  end
end
