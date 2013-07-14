class Identity < ActiveRecord::Base
	belongs_to :user

	def self.find_for_oauth(auth)
		Identity.where(:provider => auth.provider, :uid => auth.uid).first
	end

	def self.find_or_create_for_user_oauth(user,auth)
		params = { user_id: user.id, provider: auth.provider, uid: auth.uid }
		Identity.where(params).first_or_create
	end
end
