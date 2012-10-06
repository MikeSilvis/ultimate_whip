class PhotoFullSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  attributes :id, :created_at, :photo_url_thumb, :photo_url_large, :username, :created_at_in_words, :user_id, :likes, :like_count, :secret_hash
  has_one :garage
  has_many :tags

  def created_at_in_words
    time_ago_in_words(created_at) + " ago"
  end

end
