class Identity < ActiveRecord::Base
	belongs_to :user

	def self.find_for_oauth(auth)
		Identity.where(:provider => auth.provider, :uid => auth.uid).first
	end

	def self.find_or_create_for_user_oauth(auth)
		where({
       provider: auth.provider,
       uid: auth.uid,
       token: auth.credentials.token
    }).first_or_create
	end
end
