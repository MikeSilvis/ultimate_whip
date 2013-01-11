class GaragePhotoSerializer < ActiveModel::Serializer
  attributes :id, :photo_url_thumb, :tags_string
end
