class App.Tag extends Spine.Model
  @configure 'Tag', 'name', 'id'
  @extend Spine.Model.Ajax

  @url: => "/api/v1/tags"
