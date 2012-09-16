class GarageTag < ActiveRecord::Base
  attr_accessible :garage_id, :tag_id
  belongs_to :garage
  belongs_to :tag
end
