class App.Showcases extends Spine.Controller
  events:
    'click .current-featured .info' : 'setActive'
    'click .others li' : 'changeShowcase'

  constructor: ->
    super
    @images = @pushImages()
    @render()

  render: =>
    @html @view('showcases/index')(image: @renderActiveImage())
    for showcase in @images
      new App.ShowcaseItem(showcase)

  renderActiveImage: =>
    _.findWhere @images,
      active: true

  pushImages: =>
    [
      new App.Showcase(
        id: 1,
        active: true,
        photo_large: "http://s3.amazonaws.com/ultimate_whip/garage_photos/photos/000/000/001/featured/IMG_0068.jpg?1373957431",
        photo_thumb: "http://s3.amazonaws.com/ultimate_whip/garage_photos/photos/000/000/004/wide/IMG_0069.jpg?1373912617",
        caption: "BimmerMike's M3!",
        description: "Featuring BBS Rims, Gt Haus Etc, and more!"
      ),
      new App.Showcase(
        id: 2,
        active: false,
        photo_large: "http://s3.amazonaws.com/ultimate_whip/garage_photos/photos/000/000/026/featured/IMG_2181.jpeg?1373957462",
        photo_thumb: "http://s3.amazonaws.com/ultimate_whip/garage_photos/photos/000/000/101/wide/open-uri20130712-2-1794mar?1373912804",
        caption: "esquire's M3!",
        description: "Featuring Akrapovic Evolution Exhaust"
      )
    ]

  changeShowcase: (e) =>
    image.active = false for image in @images # setting all images to not be active
    image = _.findWhere @images,
              id: parseInt($(e.currentTarget).closest("li").attr('id'))
    image.active = true # setting the clicked image to active
    @render()

  setActive: (e) ->
    id = parseInt $(".showcase .others .active").attr('id')
    garages.renderActive $("##{id}_garage")
    $.scrollTo $("##{id}_garage").offset().top - (window.innerHeight / 2) + $("nav").height(), 500

class App.ShowcaseItem extends Spine.Controller

  constructor: (showcase) ->
    @showcase = showcase
    @add()

  add: =>
    $(".others").append @view('showcases/showcase')(image: @showcase)
    @container = $("##{@showcase.id}_showcase")

