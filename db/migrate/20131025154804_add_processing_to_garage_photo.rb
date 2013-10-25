class AddProcessingToGaragePhoto < ActiveRecord::Migration
  def change
    add_column :garage_photos, :avatar_processing, :boolean
  end
end
