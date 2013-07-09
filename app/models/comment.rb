class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  attr_accessible :title, :comment, :user_id, :commentable_id, :message, :commentable_type

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  default_scope :order => 'created_at ASC'
  validates_presence_of :user, :message
  delegate :username, to: :user

  def message
    comment
  end

  def message=(val)
    self.comment = val
  end
end
