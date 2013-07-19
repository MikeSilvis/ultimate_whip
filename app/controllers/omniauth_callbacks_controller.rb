class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	# Linkable accounts
	def instagram
		auth = request.env['omniauth.auth']

		if current_user.link_with_oauth(auth)
			flash[:success] = I18n.t "devise.omniauth_callbacks.success", :kind => "Instagram"
		else
			flash[:error] = I18n.t "devise.omniauth_callbacks.failure", :kind => "Instagram"
		end

		redirect_to users_account_url
	end
end