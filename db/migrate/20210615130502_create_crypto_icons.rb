class CreateCryptoIcons < ActiveRecord::Migration[6.0]
  def change
    create_table :crypto_icons do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
