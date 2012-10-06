Tag = App.Tag

class App.Tags extends Spine.Controller

  elements:
    "#photos" : "photoEl"
    "#tags"   : "tagEl"

  constructor: ->
    super
    Tag.bind "refresh", @render
    Tag.fetch()

  render: =>
    @photos = new App.Photos({el: @photoEl})
    @el = @tagEl
    $("#search-area").html(@view('tags/index')(tags: Tag.all()))
    $("#tags-select").chosen().change ->
      console.log "tags changed!"
      App.Photo.deleteAll()
      App.Photo.fetch()