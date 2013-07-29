class PhotoFullSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  attributes :id, :created_at, :photo_url_thumb, :photo_url_large, :created_at_in_words, :tags
  has_one :user
  has_one :garage

  def created_at_in_words
    time_ago_in_words(created_at) + " ago"
  end

  def tags
    garage.tags
  end

end
