class PhotoFullSerializer < ActiveModel::Serializer
  cached
  attributes :id, :created_at, :photo_url_thumb, :photo_url_large, :created_at_in_words, :tags
  has_one :user
  has_one :garage

  def tags
    garage.tags
  end

  def cache_key
    [object]
  end

end
