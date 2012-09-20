class GaragePhotoSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :photo_url_thumb, :photo_url_large, :username
  has_one :garage

end
