class Type < ActiveRecord::Base
  attr_accessible :name, :version
  has_many :makes
end
