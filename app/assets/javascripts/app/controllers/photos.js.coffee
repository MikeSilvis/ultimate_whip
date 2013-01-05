Photo = App.Photo

class App.Photos extends Spine.Controller

  events:
    "click .photo-item": "changeUrl"

  constructor: ->
    super
    @html @view('photos/index')()
    Photo.bind 'refresh', @render
    Photo.fetch()
    @setupRoutes()

  setupRoutes: ->
    if window.location.href.match(/\/photos\/(\d*)/)
      @renderModal({ target: { id: window.location.href.match(/\/photos\/(\d*)/)[1] }})
    @routes
      "/photos/:id": (params) =>
        @renderModal({ target: { id: params.id }})

  render: =>
    for photo in Photo.all().sort().reverse()
      new App.PhotoItem(photo) unless $("#photo_#{photo.id}").length
    @infinteScroll()

  changeUrl: (e) =>
    @navigate("/photos", e.target.id)

  renderModal: (e) =>
    new App.FullPhotos(e.target.id)

  deletePhoto: (e) =>
    $(".close").click()
    App.Photo.find(e.target.id).destroy()
    alerts("success", "<strong>DELETED!</strong> That photo has been deleted.")

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
