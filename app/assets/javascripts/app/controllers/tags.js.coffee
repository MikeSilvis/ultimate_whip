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
    $("#tags-select").select2().change ->
      $("#photo_container").fadeOut("slow").fadeIn("slow")
      App.Photo.deleteAll()
      App.Photo.fetch()
    if window.location.href.match(/\/tags\/(\S*)/)
      tag = window.location.href.match(/\/tags\/(\S*)/)[1]
      $("#tags-select").find("##{tag}").attr("selected", true).change()
