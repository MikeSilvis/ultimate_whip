class App.Showcase extends Spine.Model
  @configure 'Showcase', 'id', 'garage_id', 'photo_featured', 'photo_featured_iphone', 'active', 'normal_offset', 'iphone_offset', 'caption', 'description', 'showing', 'photo_thumb_wide', 'link'

  @extend Spine.Model.Ajax

  @url: => "/api/v1/showcases"

  setShowing: (bool = true) =>
    this.showing = bool
    this.save({ajax: false})
    this
