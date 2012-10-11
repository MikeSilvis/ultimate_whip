jQuery.fn.mikesModal = (action) ->
  if action == "remove"
    theLights($(this), "remove")
    mikesModal($(this), "remove")
    $("#loading-modal").remove()
    enableScrolling()
  else if action == "hide"
    theLights($(this), "remove")
    mikesModal($(this), "hide")
    $("#loading-modal").hide()
    enableScrolling()
  else
    addLoading()
    disableScrolling()
    theLights($(this))
    mikesModal($(this))

  $(this)

theLights = (modalBox, action) ->
  if action == "remove"
    $("#the-lights").remove()
  else
    $("body").append("<div id='the-lights'></div>")
    $("#the-lights").css("height": $(document).height())

mikesModal = (modalBox, action) ->
  if action == "hide"
    modalBox.hide()
  else if action == "remove"
    modalBox.remove()
  else
    addListeners(modalBox)
    modalBox.find("img").css("max-width":  ((window.innerWidth * .9) - 300), "max-height":  (window.innerHeight * .8))
    modalBox.find("img").load ->
      modalBox.css("margin-left":("-" + (modalBox.width() / 2) + "px"), "top":($(window).scrollTop() + 50 + "px")).fadeIn("slow")
      $("#loading-modal").remove()

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

  $("body").append("<div id='loading-modal'></div>")
  $("#loading-modal").css("top":($(window).scrollTop() + 300 + "px"))
  spinner = new Spinner(opts).spin(document.getElementById("loading-modal"))

addListeners = (modalBox) ->
  $(document).keyup (e) ->
    $(".close").click() if e.keyCode is 27
  $(document).click (e) ->
    $(".close").click() if e.target.id is "the-lights"
  modalBox.find(".close").click (e) ->
    modalBox.mikesModal("remove")

scrollPosition = ->
  [self.pageXOffset or document.documentElement.scrollLeft or document.body.scrollLeft, self.pageYOffset or document.documentElement.scrollTop or document.body.scrollTop]

disableScrolling = ->
  html = jQuery("html") # it would make more sense to apply this to body, but IE7 won't have that
  html.data "scroll-position", scrollPosition
  html.data "previous-overflow", html.css("overflow")
  html.css "overflow", "hidden"
  window.scrollTo scrollPosition()[0], scrollPosition()[1]

enableScrolling = ->
  html = jQuery("html")
  scrollPosition = html.data("scroll-position")
  html.css "overflow", html.data("previous-overflow")
  window.scrollTo scrollPosition()[0], scrollPosition()[1]

