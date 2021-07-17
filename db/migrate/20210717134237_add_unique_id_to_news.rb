class AddUniqueIdToNews < ActiveRecord::Migration[6.1]
  def change
    add_column :news, :unique_id, :string, null: false
  end
end
