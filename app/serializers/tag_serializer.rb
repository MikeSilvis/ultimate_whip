class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :seo_friendly_name
  def seo_friendly_name
    name.parameterize
  end
end