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
    $("#photo_container").append(@view('photos/photo')(@photo))

class App.PhotoModal extends Spine.Controller

  constructor: (id)->
    @id = id
    Photo.bind 'refresh', @render
    Photo.fetchSingle({id: @id})

  render: =>
    $("#mikes-modal").html(@view('photos/modal')(Photo.find(@id)))
    $(".mikes-modal").css("top":($(window).scrollTop() + 50 + "px")).hide()
    addLoading()
    @listenEvents(@id)

  listenEvents: (id) =>
    $(".mikes-modal img").load ->
      marginLeft = ($(window).width() - $(".mikes-modal").width()) / 2
      $(".mikes-modal").css("margin-left":(marginLeft + "px")).fadeIn("slow")
      $("#the-lights").show().css("height": $(document).height())
      $("#loading-modal").hide()
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

addLoading = () ->
  opts =
    lines: 9 # The number of lines to draw
    length: 30 # The length of each line
    width: 20 # The line thickness
    radius: 40 # The radius of the inner circle
    corners: 1 # Corner roundness (0..1)
    rotate: 19 # The rotation offset
    color: "#fff" # #rgb or #rrggbb
    speed: 1.2 # Rounds per second
    trail: 42 # Afterglow percentage
    shadow: false # Whether to render a shadow
    hwaccel: false # Whether to use hardware acceleration
    className: "spinner" # The CSS class to assign to the spinner
    zIndex: 2e9 # The z-index (defaults to 2000000000)
    top: "auto" # Top position relative to parent in px
    left: "auto" # Left position relative to parent in px

  $("#loading-modal").show().css("top":($(window).scrollTop() + 300 + "px"))
  target = document.getElementById("loading-modal")
  spinner = new Spinner(opts).spin(target)