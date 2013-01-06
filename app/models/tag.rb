class Tag < ActiveRecord::Base
  attr_accessible :name
  def seo_friendly_name
    name.parameterize
  end
end
