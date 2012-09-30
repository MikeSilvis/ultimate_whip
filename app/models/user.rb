require 'digest/md5'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_liker
  attr_accessible :email, :password, :username, :password_confirmation, :remember_me
  has_many :vehicles, class_name: "Garage"
  has_many :likes
  validates_uniqueness_of :username, :email

  def secret_hash
    Digest::MD5.hexdigest("#{email}-#{username}")
  end
end
