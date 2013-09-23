class AddGaragePhotoIdToShowcase < ActiveRecord::Migration
  def change
    add_column :showcases, :garage_photo_id, :integer
  end
end
