class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :title
      t.string :domain
      t.text :summary
      t.string :preview_url
      t.string :published_date

      t.timestamps
    end
  end
end
