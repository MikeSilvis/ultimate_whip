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
    @addMasonry()
    @windowHeight or= ($(window).height())
    @infinteScroll(@windowHeight)

  renderModal: (e) =>
    Photo.unbind "refresh"
    new App.PhotoModal(e.target.id)

  addMasonry: =>
    container = $("#photo_container")
    container.imagesLoaded ->
      container.masonry
        itemSelector: ".photo-item"
        isAnimated: true
        isFitWidth: true

  closeModal: (e) =>
    Photo.bind 'refresh', @render

  infinteScroll:  (windowHeight) =>
    $(window).bind "scroll", ->
      if $(window).scrollTop() > $(document).height() - windowHeight
        $(window).unbind "scroll"
        Photo.fetch()

class App.PhotoItem extends Spine.Controller

  constructor: (photo) ->
    @photo = photo
    @render()

  render: =>
    $("#photo_container").append(@view('photos/photo')(@photo))

class App.PhotoModal extends Spine.Controller

  constructor: (id)->
    @id = id
    Photo.bind 'refresh', @render
    Photo.fetchSingle({id: @id})

  render: =>
    $("#modal-container").html(@view('photos/modal')(Photo.find(@id)))
    $("#mikes-modal").mikesModal()
    @listenEvents(@id)

  listenEvents: (id) =>
    $(".tags a").click (e)->
      e.preventDefault()
      @filterTagsOnClick()
    $(".new-comment").keyup (e) ->
      if e.keyCode is 13
        e.preventDefault()
        @createComment()

  filterTagsOnClick = () ->
    $("#tags-select").find("##{$(this).attr("data-tag")}").attr("selected", true).trigger("liszt:updated")
    App.Photo.deleteAll()
    App.Photo.fetch()
    $(".close").click()

  createComment = () ->
    App.Comment.create message: $(".new-comment").val(), commentable_id: id
    $(".new-comment").val("")
    Photo.fetch({id: id})
