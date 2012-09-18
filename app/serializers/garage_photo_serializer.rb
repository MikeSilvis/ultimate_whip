class GaragePhotoSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :photo_file_name, :photo_url_thumb, :photo_url_large

end
