class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  attr_accessible :title, :comment, :user_id, :commentable_id, :message

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  default_scope :order => 'created_at ASC'
  validates_presence_of :user
  delegate :username, to: :user

  def message
    comment
  end

  def message=(val)
    comment = val
  end
end
