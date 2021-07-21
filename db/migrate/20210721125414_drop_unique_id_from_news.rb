class DropUniqueIdFromNews < ActiveRecord::Migration[6.1]
  def change
    remove_column :news, :unique_id
  end
end
