class Api::V1::CommentsController < ApiController
  before_filter :authenticate_user!, only: :create

  def create
    object = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
    comment = object.comments.create(user_id: current_user.id, comment: params[:comment][:message])
    send_emails(object,comment)
    render json: true
  end

  def index
    render json: Comment.where('commentable_id = ? AND commentable_type = ?',  params[:commentable_id], params[:commentable_type]).includes(:user).order(:created_at), root: false
  end

private

  def send_emails(object, comment)
    #object.comments.each do |c|
      #UserMailer.notify_photo_comment(comments).deliver
    #end
  end

end
