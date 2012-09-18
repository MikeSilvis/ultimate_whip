class Model < ActiveRecord::Base
  attr_accessible :name, :make, :type
  belongs_to :make
end
