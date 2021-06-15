class AddImageUrlToDerivatives < ActiveRecord::Migration[6.0]
  def change
    add_column :derivatives, :image_url, :string
  end
end
