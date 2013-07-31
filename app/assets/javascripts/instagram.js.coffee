$ ->
  if $(".instagram-button").length
    new InstagramModal()
    new BindAddding()

class BindAddding
  constructor: ->
    @bindThumbnailImageHover()
    @bindAddImageHover()
    @bindCheckMarkHover()
    @bindClickThumbnail()

  bindAddImageHover: =>
    $(".add-image").hover (->
      $(this).show()
      $('.add-image').prev().addClass 'thumbnail-hover'
    ), ->
      $(this).hide()
      $('.add-image').prev().removeClass 'thumbnail-hover'

  bindCheckMarkHover: =>
    $(".photo").on "mouseenter", ".checkmark", ->
      $('.add-image').parent().find(".img").addClass 'thumbnail-hover'
    $(".photo").on "mouseleave", ".checkmark", ->
      $('.checkmark').parent().find(".img").removeClass 'thumbnail-hover'

  bindThumbnailImageHover: =>
    $(".photo").on "mouseenter", ".instagram .img", ->
      $(".add-image").insertAfter $(this)
      $(".add-image").css
        display: "block"
        position: "relative"
        top: -60
        left: 25
      $(".add-image").hide() if !!$(this).parent().find("input").attr("checked")
    $(".photo").on "mouseleave", ".instagram .img", ->
      $(".add-image").hide()

  bindClickThumbnail: =>
    $(".photo").on 'click', '.instagram .img, .add-image, .checkmark', ->
      box = $(this).parent().find("input")
      $(".add-image").hide()
      box.attr "checked", !box.attr("checked")
      if !!box.attr("checked")
        $(".upload").removeClass("disabled").addClass("enabled")
        $(this).parent().append $("<img src='/assets/258-checkmark@2x.png' class='checkmark'>")
        $(this).parent().find(".img").addClass(".thumbnail-hover")
        $(this).parent().find(".checkmark").css
          display: 'block'
          position: "relative"
          top: -60
          left: 25
      else
        $(".add-image").show()
        $(".upload").addClass "disabled" if $("input[name='photo[]']:checked").length == 0
        $(this).parent().find(".checkmark").remove()

class Instagram
  url = "https://api.instagram.com/v1/"
  meta = $("meta[name='instagram-token']").attr("content")
  initialUrl = "#{url}users/self/media/recent?access_token=#{meta}&callback=?"

  getFeed:  =>
    @getData(initialUrl)

  getData: (requestURL) =>
    $.getJSON(
      requestURL,
      $(".loading").show()
    ).done (data) =>
      $(".loading").hide()
      @storeData(data)

  storeData: (data) =>
    @appendData(data)
    @getData("#{data.pagination.next_url}?callback=?") if data.pagination.next_url

  appendData: (data) =>
    for d in data.data
      $(".pics").append("<div class='instagram'>")
      $(".instagram").last().append $("<img src='#{d.images.thumbnail.url}' class='img'>")
      $(".instagram").last().append $("<input type='checkbox' name='photo[]' value='#{d.images.standard_resolution.url}' style='display:none;'>")

class InstagramModal
  constructor: ->
    @bindOpen()
    @bindSubmit()
    @bindInstagramSuccess()

  bindOpen: =>
    $(".instagram-button").click =>
      if $("meta[name='instagram-token']").length
        @open()
      else
        window.location = '/users/auth/instagram'

  bindInstagramSuccess: =>
    if window.location.search == "?instagram=success"
      @open()

  open: =>
    $("#instagramModal").modal()
    new Instagram().getFeed()
    $("body").css("overflow", "hidden")

  bindSubmit: =>
    $(".disabled").click (e) ->
      e.preventDefault()
    $(".modal-footer").on 'click', '.upload.enabled', (e) ->
      e.preventDefault()

      images = []
      $("input[name='photo[]']:checked").each ->
        images.push $(this).val()
      $('.upload').removeClass('enabled').addClass("disabled")
      $('.upload').text 'loading...'

      $.ajax(
        url: "/api/v1/garages/#{$("#garage_photo_garage_id").find(":selected").val()}"
        type: "PUT"
        data: { images: images }
      ).done (data) ->
        window.location = '/photos'

