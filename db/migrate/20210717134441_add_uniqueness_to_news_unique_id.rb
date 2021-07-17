class AddUniquenessToNewsUniqueId < ActiveRecord::Migration[6.1]
  def change
    add_index :news, :unique_id, unique: true
  end
end
