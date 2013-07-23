class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  include Rails.application.routes.url_helpers
  attr_accessible :title, :comment, :user_id, :commentable_id, :message, :commentable_type

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates_presence_of :user, :message
  delegate :username, to: :user

  def message
    comment
  end

  def message=(val)
    self.comment = val
  end

  def url
    if self.commentable_type == "GaragePhoto"
      photo_path(self.commentable)
    else
      tag_path(self.commentable.user.username)
    end
  end

end
