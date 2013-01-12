class Api::V1::CommentsController < ApplicationController
  before_filter :authenticate_user!, only: :create

  def create
    # For now this assumes that only garage_photos can have comments
    photo = GaragePhoto.find(params[:commentable_id])
    comment = photo.comments.create(user_id: current_user.id, comment: params[:message])

    UserMailer.notify_photo_comment(comment).deliver
    render json: true
  end

  def index
    render json: Comment.where(commentable_id: params[:commentable_id]).includes(:user), root: false
  end

end
