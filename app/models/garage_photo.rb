class GaragePhoto < ActiveRecord::Base
  attr_accessible :garage_id
  belongs_to :garage
  has_attached_file :avatar,
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :styles => {
                    :medium => "300x300>",
                    :thumb => "100x100>"
                 }
end
