class UserMailer < ActionMailer::Base
  default from: "hello@auxotic.com",
          return_path: "hello@auxotic.com"

  def notify_photo_comment(comment, user)
    @comment = comment
    @to_user = user
    @from_user = comment.user

    mail :to => @to_user.email, subject: "#{@from_user.username} left you a comment!", :template_name => "notify_photo_comment"
  end

end
