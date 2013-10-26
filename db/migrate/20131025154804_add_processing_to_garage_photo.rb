class AddProcessingToGaragePhoto < ActiveRecord::Migration
  def change
    add_column :garage_photos, :photo_processing, :boolean
  end
end
