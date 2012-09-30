module UsersHelper
  def current_user_meta_tags
    if current_user
      tag('meta', name: 'user-secret-key', content: current_user.secret_hash)
    else
      ""
    end
  end
end
