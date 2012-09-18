Photo = App.Photo

class App.Photos extends Spine.Controller

  constructor: ->
    super
    Photo.bind 'refresh', @render
    Photo.fetch()

  render: =>
    @html @view('photos/index')(@photos)
    for photo in Photo.all()
      new App.PhotoItem(photo, _i)


class App.PhotoItem extends Spine.Controller

  constructor: (photo) ->
    @photo = photo
    @render()

  render: =>
    $("#photo_container").append(@view('photos/photo')(@photo))