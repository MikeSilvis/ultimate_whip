FullPhoto = App.FullPhoto

class App.FullPhotos extends Spine.Controller

  constructor: ->
    super
    FullPhoto.bind 'refresh', @render
    FullPhoto.fetch({id: @id})

  render: =>
    @photo = FullPhoto.find(@id)
    @html @view('full_photos/index')(@photo)
    $(".mikes-modal").mikesModal()
    FullPhoto.unbind "refresh"
    new App.Comments(el: @el.find(".comments"), object: @photo)
    @setTitleBar()
    @metaTags()
    @location = $(window).scrollTop()
    @listenEvents()
    @setupRoutes()

  setTitleBar: =>
    url = location.pathname.replace(/\/photos\//g," ").split("-")
    url.shift()
    make = url.shift()
    model = url.join " "
    @oldTitleBar = $("title").text()
    $('title').text "Auxotic - #{make} #{model}"

  metaTags: =>
    keywords = $("meta[name='keywords']").attr('content')
    tags = _.map App.FullPhoto.all()[0].tags, (obj) ->
             obj.name
    $("meta[name='keywords']").attr('content',"#{keywords}, #{tags}")

  setupRoutes: ->
    $(".mikes-modal").bind 'close', (e) =>
      $(window).scrollTop(@location)
      $("title").text @oldTitleBar
      @navigate("/")
    #$(window).bind "hashchange", ->
      #$(".mikes-modal").trigger "close"
      #$(window).unbind "hashchange"

  listenEvents: =>
    $(".mikes-modal").bind "loaded", =>
      $(window).scrollTop(@location)
    $(".tag").click (e) =>
      e.preventDefault()
      $(".mikes-modal").trigger("close")
      @navigate("/tags", e.target.id)
    #$(".facebook").click (e) ->
      #e.preventDefault()
      #window.open("https://www.facebook.com/sharer/sharer.php?s=100&p%5Btitle%5D=#{@photo.facebook_title()}&p%5Bsummary%5D=#{@photo.facebook_share_summary()}&p%5Burl%5D=#{@photo.facebook_full_url()}&p[images][0]=#{@photo.facebook_share_image()}",'sharer','toolbar=0,status=0,width=548,height=325');
    #$(".twitter").click (e) ->
      #e.preventDefault()
      #window.open("https://twitter.com/intent/tweet?text=#{@photo.twitter_tweet()}",'sharer','toolbar=0,status=0,width=548,height=325');
