class AddOriginalUrlToGaragePhoto < ActiveRecord::Migration
  def change
    add_column :garage_photos, :original_url, :string
  end
end
