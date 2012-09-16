class MakeSerializer < ActiveModel::Serializer
  attributes :id, :model, :body_style, :version

  def body_style
    object.type.name
  end

  def model
    object.model.name
  end

  def version
    object.type.version
  end
end
