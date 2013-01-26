class AddIndexToCreatedAt < ActiveRecord::Migration
  def change
    add_index :garage_photos, :created_at
    add_index :garage_photos, :original_url
    add_index :garage_photos, :garage_id
    add_index :garages, :model_id
    add_index :garages, :user_id
  end
end
