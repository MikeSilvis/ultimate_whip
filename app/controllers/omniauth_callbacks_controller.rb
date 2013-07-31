class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  before_filter :authenticate_user!, only: [:instagram]

	def instagram
		auth = request.env['omniauth.auth']

		if current_user.link_with_oauth(auth)
			flash[:success] = I18n.t "devise.omniauth_callbacks.success", :kind => "Instagram"
		else
			flash[:error] = I18n.t "devise.omniauth_callbacks.failure", :kind => "Instagram"
		end

		redirect_to new_photo_path(instagram: "success")
	end
end
