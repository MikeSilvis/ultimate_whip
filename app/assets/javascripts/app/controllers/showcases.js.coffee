class App.Showcases extends Spine.Controller
  events:
    #'click .current-featured .info' : 'openShowing'
    'click .others li' : 'changeShowcase'

  constructor: ->
    super
    App.Showcase.bind 'refresh change', @render

  render: =>
    @html @view('showcases/index')(image: @activeImage())
    for showcase in App.Showcase.all()
      new App.ShowcaseItem(showcase, _i)

  activeImage: (setToId = false) =>
    if setToId
      App.Showcase.findByAttribute('id', setToId).setShowing(true)
    else
      App.Showcase.findByAttribute("showing", true) || App.Showcase.first()

  changeShowcase: (e) =>
    for image in App.Showcase.all()
      image.setShowing(false)
    @activeImage(parseInt($(e.currentTarget).closest("li").attr('id')))

  #openShowing: (e) ->
    #id = parseInt $(".showcase .others .showing").attr('id')
    #garages.rendershowing $("##{id}_garage")
    #$.scrollTo $("##{id}_garage").offset().top - (window.innerHeight / 2) + $("nav").height(), 500

class App.ShowcaseItem extends Spine.Controller

  constructor: (showcase, index) ->
    @showcase = showcase
    @index = index
    @shouldShow = (@showcase.showing || ((index == 0) && (App.Showcase.findByAttribute("showing", true) == null)))
    @add()

  add: =>
    $(".others").append @view('showcases/showcase')(image: @showcase, shouldShow: @shouldShow)
    @container = $("##{@showcase.id}_showcase")

