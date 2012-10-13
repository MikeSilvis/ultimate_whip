Photo = App.Photo

class App.Photos extends Spine.Controller

  events:
    "click .photo-item": "changeUrl"

  constructor: ->
    super
    Photo.bind 'refresh', @render
    Photo.fetch()
    @setupRoutes()

  setupRoutes: ->
    @routes
      "/pictures/:id": (params) =>
        @renderModal({ target: { id: params.id }})

    $(document).bind 'modal-removed', (e) =>
      e.preventDefault()
      @navigate('')

    # HACK! This basically "fakes" a url
    # change to get it to work on first page load
    old = location.href
    location.href = "#/loading/"
    setTimeout (-> location.href = old), 200

  render: =>
    @html @view('photos/index')()
    for photo in Photo.all().sort().reverse()
      new App.PhotoItem(photo)
    # @addMasonry()
    @infinteScroll()

  changeUrl: (e) =>
    @navigate("/pictures", e.target.id)

  renderModal: (e) =>
    new App.FullPhotos(e.target.id)

  addMasonry: =>
    container = $("#photo_container")
    container.imagesLoaded ->
      container.masonry
        itemSelector: ".photo-item"
        isAnimated: true
        isFitWidth: true

  deletePhoto: (e) =>
    $(".close").click()
    App.Photo.find(e.target.id).destroy()
    alerts("success", "<strong>DELETED!</strong> That photo has been deleted.")

  infinteScroll:  =>
    $(window).bind "scroll", ->
      if $(window).scrollTop() > $(document).height() - window.innerHeight
        $(window).unbind "scroll"
        Photo.fetch()

class App.PhotoItem extends Spine.Controller

  constructor: (photo) ->
    @photo = photo
    @render()

  render: =>
    $("#photo_container").append(@view('photos/photo')(@photo))