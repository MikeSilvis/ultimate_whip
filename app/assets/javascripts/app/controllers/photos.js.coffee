Photo = App.Photo

class App.Photos extends Spine.Controller
  events:
    "click .photo-item": "renderModal"
    "click .close" : "closeModal"

  constructor: ->
    super
    Photo.bind 'refresh', @render
    Photo.fetch()

  render: =>
    @html @view('photos/index')(@photos)
    for photo in Photo.all()
      new App.PhotoItem(photo)
    @masonary()

  renderModal: (e) =>
    Photo.unbind "refresh"
    new App.PhotoModal(e.target.id)

  masonary: =>
    container = $("#photo_container")
    container.imagesLoaded ->
      container.masonry
        itemSelector: ".photo-item"
        isAnimated: true

  closeModal: (e) =>
    Photo.bind 'refresh', @render
    $(".mikes-modal").remove()
    $("#the-lights").hide()

class App.PhotoItem extends Spine.Controller

  constructor: (photo) ->
    @photo = photo
    @render()

  render: =>
    $("#photo_container").append(@view('photos/photo')(@photo))

class App.PhotoModal extends Spine.Controller

  constructor: (id)->
    @id = id
    $("#the-lights").show()
    Photo.bind 'refresh', @render
    Photo.fetch({id: @id})

  render: =>
    $("#mikes-modal").html(@view('photos/modal')(Photo.find(@id)))
    @listenEvents(@id)

  listenEvents: (id) =>
    $(document).keyup (e) ->
      $(".close").click() if e.keyCode is 27
    $(document).click (e) ->
      $(".close").click() if e.target.id is "the-lights"
    $(".new-comment").keyup (e) ->
      if e.keyCode is 13
        e.preventDefault()
        App.Comment.create message: $(".new-comment").val(), commentable_id: id
        $(".new-comment").val("")
        Photo.fetch({id: id})

