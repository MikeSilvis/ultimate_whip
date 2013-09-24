class PhotoFullSerializer < ActiveModel::Serializer
  cached
  attributes :id, :created_at, :photo_url_thumb, :photo_url_large, :tags
  has_one :user
  has_one :garage

  def tags
    garage.tags - tags_to_reject
  end

  def tags_to_reject
    ActsAsTaggableOn::Tag.where('lower(name) = lower(?) or lower(name) = lower(?) or lower(name) = lower(?) or lower(name) = lower(?)', garage.model.name, garage.year.to_s, garage.make.name, garage.user.username)
  end

  def cache_key
    [object]
  end

end
