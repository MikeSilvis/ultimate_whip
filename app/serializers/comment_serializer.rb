class CommentSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  attributes :id, :username, :created_at_in_words, :created_at, :message

  def created_at_in_words
    time_ago_in_words(created_at)
  end

end
