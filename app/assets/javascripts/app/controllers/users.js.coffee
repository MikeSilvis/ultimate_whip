class App.CurrentUser extends Spine.Controller

  constructor: ->
    super
    @render()

  render: =>
    window.tags = new App.Tags({el: $("#search-area")})
