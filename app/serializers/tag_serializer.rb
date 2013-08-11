class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :seo_friendly_name
  cached

  def seo_friendly_name
    name.parameterize
  end

  def cache_key
    [object]
  end
end
