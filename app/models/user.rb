require 'digest/md5'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  acts_as_liker
  uniquify :token, :length => 32
  has_many :vehicles, -> { order('created_at') }, class_name: "Garage"
  has_many :photos, :through => :vehicles
  has_many :likes
  has_many :identities
  validates_uniqueness_of :username, :email
  accepts_nested_attributes_for :vehicles, allow_destroy: true

  def secret_hash
    Digest::MD5.hexdigest("#{email}-#{username}")
  end

  def link_with_oauth(auth)
    self.identities.find_or_create_for_user_oauth(auth)
  end

  def is_linked_to?(provider)
    self.identities.where(provider: provider).present?
  end

  def instagram
    self.identities.where(provider: "instagram").first
  end

end
