class UserMailer < ActionMailer::Base
  default from: "notification@m3snaps.com",
          return_path: "info@m3snaps.com"

  def notify_photo_comment(comment) 
    @comment = comment
    @to_user = comment.commentable.user
    @from_user = comment.user

    mail(:to => @to_user.email, 
        :subject => "#{@from_user.username} commented on your photo!",
        :template_name => "notify_photo_comment" )
  end

end
