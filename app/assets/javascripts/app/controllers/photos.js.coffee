Photo = App.Photo

class App.Photos extends Spine.Controller

  events:
    "click .photo-item": "changeUrl"

  constructor: ->
    super
    @html @view('photos/index')()
    Photo.bind 'refresh', @render
    Photo.fetch()


  render: =>
    if @tags != $("#tags-select").val()
      @html @view('photos/index')()
    for photo in Photo.all().sort().reverse()
      new App.PhotoItem(photo) unless $("#photo_#{photo.id}").length
    @tags = $("#tags-select").val()
    @setupRoutes()
    @infinteScroll()

  setupRoutes: ->
    @routes
      "/photos/:id": (params) =>
        new App.FullPhotos(parseInt(params.id))
      "/tags/:id": (params) =>
        $("#tags-select").find("##{params.id}").attr("selected", true).change()
    Spine.Route.setup(history: true)

  changeUrl: (e) =>
    @navigate("/photos", e.target.id)

  infinteScroll:  =>
    $(window).bind "scroll", ->
      if $(window).scrollTop() > $(document).height() - window.innerHeight - 500
        $(window).unbind "scroll"
        Photo.fetch()

class App.PhotoItem extends Spine.Controller

  constructor: (photo) ->
    @photo = photo
    @render()

  render: =>
    $("#photo_container").append(@view('photos/photo')(@photo))
