class Showcase < ActiveRecord::Base
  SHOWCASE_NUM = 3
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
    query = self.includes(:garage_photo).limit(SHOWCASE_NUM).where("active = ?", true).order("RANDOM()")
    if tag.present?
      query = query.includes(:tag).references(:tag).where("lower(tags.name) = lower(?)", tag)
      if query.count < SHOWCASE_NUM
        # TODO: Create showcases on the fly with vehicles in them
      end
    else
      query = query.where("tag_id is null")
    end
    query
  end

end
