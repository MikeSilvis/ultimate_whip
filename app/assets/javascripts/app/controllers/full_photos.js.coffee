FullPhoto = App.FullPhoto

class App.FullPhotos extends Spine.Controller

  constructor: (id)->
    super
    @id = id
    FullPhoto.bind 'refresh', @render
    FullPhoto.fetch({id: @id})

  render: =>
    $("#modal-container").html(@view('full_photos/index')(FullPhoto.find(@id)))
    $(".mikes-modal").mikesModal()
    FullPhoto.unbind "refresh"
    new App.Comments({el: $("#comments")}, @id)
    @listenEvents(@id)
    @setupRoutes()

  setupRoutes: ->
    $(".mikes-modal").bind 'close', (e) =>
      location = $(window).scrollTop()
      @navigate('')
      $(window).scrollTop(location)
    $(window).bind "hashchange", ->
      $(".mikes-modal").trigger "close"
      $(window).unbind "hashchange"


  listenEvents: (id) =>
    photo = FullPhoto.find(id)
    $(".tag").click (e)->
      e.preventDefault()
      tag = $(this).attr("data-tag").replace RegExp(" ", "g"), "-"
      $("#tags-select").find("##{tag}").attr("selected", true).change()
      $(".mikes-modal").trigger("close")
    $(".facebook").click (e) ->
      e.preventDefault();
      window.open("https://www.facebook.com/sharer/sharer.php?s=100&p%5Btitle%5D=#{photo.facebook_title()}&p%5Bsummary%5D=#{photo.facebook_share_summary()}&p%5Burl%5D=#{photo.facebook_full_url()}",'sharer','toolbar=0,status=0,width=548,height=325');
    $(".twitter").click (e) ->
      e.preventDefault()
      window.open("https://twitter.com/intent/tweet?text=#{photo.twitter_tweet()}",'sharer','toolbar=0,status=0,width=548,height=325');

alerts = (type, message) ->
    $("#alert-js").append("<div class='alert alert-#{type}' id='files-uploaded-succesfully'>#{message}</div>")
    $(".alert").delay(10000).fadeOut 1000, ->
      $(this).remove()
