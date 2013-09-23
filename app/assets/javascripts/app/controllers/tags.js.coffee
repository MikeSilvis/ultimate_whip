Tag = App.Tag

class App.Tags extends Spine.Controller

  elements:
    ".feed"         : "garageEl"
    "#tags-select"  : 'tags'

  constructor: ->
    super
    @listenForHotKeys()
    Tag.bind "refresh", @render
    Tag.fetch()

  render: =>
    window.garages = new App.Garages({el: $('.feed')})
    @html @view('tags/index')(tags: Tag.all())
    @setupRoutes()
    new App.Showcases({el: $(".showcase")})
    @tags.select2(minimumInputLength: 2).change =>
      @navigateForTag()
      App.Showcase.deleteAll()
      App.Showcase.fetch({data: "tag_name=#{@lastTag()}"})
      App.Garage.deleteAll()
      App.Garage.fetch()
    @tags.change()

  navigateForTag: =>
    if @tags.val()
      @navigate("/tags", @lastTag().seoName())
    else if window.location.pathname.match(/tags/)
      @navigate("/")

  lastTag: =>
    if @tags.val()
      @tags.val().pop()
    else
      ''
  setupRoutes: ->
    @routes
      "/photos/:id": (params) =>
        new App.FullPhotos(el: $("#modal-container"), id: parseInt(params.id))
      "/tags/:id": (params) =>
        @tags.find("##{params.id}").attr('selected', true).change()
    Spine.Route.setup(history: true)

  listenForHotKeys: =>
    $(document).keydown (event) ->
      if event.which is 191
        event.preventDefault()
        $("#search-area input").focus()
      if event.which is 27
        $("#search-area input").blur()

