class AddAttachmentPhotoToGaragePhotos < ActiveRecord::Migration
  def self.up
    change_table :garage_photos do |t|
      t.has_attached_file :photo
    end
  end

  def self.down
    drop_attached_file :garage_photos, :photo
  end
end
