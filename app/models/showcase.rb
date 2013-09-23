class Showcase < ActiveRecord::Base
  belongs_to :garage
  belongs_to :tag
  belongs_to :garage_photo
  validates :garage_id, presence: true
  validates :garage_photo_id, presence: true
  validates :caption, presence: true
  delegate :photo_featured, :photo_featured_iphone, :photo_thumb_wide, to: :garage_photo

  def normal_offset
    self[:normal_offset] || 0
  end

  def iphone_offset
    self[:iphone_offset] || 0
  end

  def self.find_with_tag(tag = nil)
    query = self.includes(:garage_photo).limit(3).where("active = ?", true)
    if tag
      query = query.includes(:tag).where("lower(tags.name) = lower(?) or tags.name is null or tags.name is not null", tag).order("lower(tags.name) = lower('#{tag}') DESC, RANDOM()")
    else
      query = query.order("RANDOM()")
    end
    query
  end

end
