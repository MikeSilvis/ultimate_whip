Photo = App.Photo

class App.Photos extends Spine.Controller
  events:
    "click .photo-item": "renderModal"
    "click .close-mikes-modal" : "closeModal"

  constructor: ->
    super
    Photo.bind 'refresh', @render
    Photo.fetch()

  render: =>
    @html @view('photos/index')(@photos)
    for photo in Photo.all()
      new App.PhotoItem(photo)
    @masonary()

  renderModal: =>
    new App.PhotoModal()

  masonary: =>
    container = $("#photo_container")
    container.imagesLoaded ->
      container.masonry
        itemSelector: ".photo-item"
        isAnimated: true

  closeModal: (e) =>
    $(".mikes-modal-container").hide()
    $("#the-lights").fadeTo("slow",0);

class App.PhotoItem extends Spine.Controller

  constructor: (photo) ->
    @photo = photo
    @render()

  render: =>
    $("#photo_container").append(@view('photos/photo')(@photo))

class App.PhotoModal extends Spine.Controller

  constructor: ->
    $("#the-lights").css display: "block"
    $("#the-lights").fadeTo "slow", 0.9
    @render()

  render: =>
    $("#photo_container").append(@view('photos/modal'))