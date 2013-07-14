require 'digest/md5'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  acts_as_liker
  uniquify :token, :length => 32
  attr_accessible :email, :password, :username, :password_confirmation, :remember_me
  has_many :vehicles, class_name: "Garage"
  has_many :photos, :through => :vehicles
  has_many :likes
  has_many :identities
  validates_uniqueness_of :username, :email
  accepts_nested_attributes_for :vehicles

  def secret_hash
    Digest::MD5.hexdigest("#{email}-#{username}")
  end

  def link_with_oauth(auth)
    Identity.find_or_create_for_user_oauth(self,auth)
  end

  def has_linked_to?(provider)
    Identity.where({user_id: id, provider: provider}).exists?
  end
end
