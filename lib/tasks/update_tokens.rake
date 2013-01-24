task :update_tokens => :environment do
  def generate_token
    token = nil
    options = { :length => 32, :chars => ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a }

    while(token.nil? || User.where(:token => token).count > 0)
      token = Array.new(options[:length]) { options[:chars].to_a[rand(options[:chars].to_a.size)] }.join
    end

    token
  end

  User.where(:token => nil).each do |user|
    user.update_attribute(:token, generate_token)
  end

  puts 'All tokens updated'
end
