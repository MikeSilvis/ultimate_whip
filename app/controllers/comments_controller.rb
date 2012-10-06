class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    # For now this assumes that only garage_photos can have comments
    GaragePhoto.find(params[:commentable_id]).comments.create(user_id: current_user.id, comment: params[:message])
    render json: true
  end

  def index
    render json: Comment.find_all_by_commentable_id(params[:commentable_id]), root: false
  end

end
