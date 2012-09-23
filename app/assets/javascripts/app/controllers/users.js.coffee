class App.CurrentUser extends Spine.Controller

  constructor: ->
    super
    @render()

  render: =>
    @tags = new App.Tags({el: @el})
