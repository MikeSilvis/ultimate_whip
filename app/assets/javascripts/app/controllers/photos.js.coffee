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
    @windowHeight or= ($(window).height())
    @infinteScroll(@windowHeight)

  renderModal: (e) =>
    Photo.unbind "refresh"
    new App.PhotoModal(e.target.id)

  masonary: =>
    container = $("#photo_container")
    container.imagesLoaded ->
      container.isotope
        itemSelector: ".photo-item"
        isAnimated: true
        isFitWidth: true

  closeModal: (e) =>
    Photo.bind 'refresh', @render
    $(".mikes-modal").remove()
    $("#the-lights").hide()

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
    # $('#photo_container').append( @view('photos/photo')(@photo) ).isotope( 'appended', @view('photos/photo')(@photo) );
    $("#photo_container").append(@view('photos/photo')(@photo))

class App.PhotoModal extends Spine.Controller

  constructor: (id)->
    @id = id
    $("#the-lights").show().css("height": $(document).height())
    Photo.bind 'refresh', @render
    Photo.fetch({id: @id})

  render: =>
    $("#mikes-modal").html(@view('photos/modal')(Photo.find(@id)))
    $(".mikes-modal").css("top":($(window).scrollTop() + 50 + "px"))
    @listenEvents(@id)

  listenEvents: (id) =>
    $(".mikes-modal img").load ->
      marginLeft = ($(window).width() - $(".mikes-modal").width()) / 2
      $(".mikes-modal").css("margin-left":(marginLeft + "px"))
    $(".tags a").click (e)->
      e.preventDefault()
      $("#tags-select").find("##{$(this).attr("data-tag")}").attr("selected", true).trigger("liszt:updated")
      App.Photo.deleteAll()
      App.Photo.fetch()
      $(".close").click()
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

