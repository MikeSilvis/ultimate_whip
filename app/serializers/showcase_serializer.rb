class ShowcaseSerializer < ActiveModel::Serializer
  cached
  attributes :id, :garage_id, :photo_featured, :photo_featured_iphone, :photo_thumb_wide, :active, :normal_offset, :iphone_offset, :caption, :description, :showing, :cid
  alias_method :cid, :id

  def showing
    false
  end

end
