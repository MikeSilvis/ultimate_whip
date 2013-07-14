class App.Garage extends Spine.Model
  @configure 'Garage', 'id', 'user', 'year', 'updated_at_short'

  @extend Spine.Model.Ajax

  @url: "/api/v1/garages"

  constructor: ->
    @photoLimit = 8
    @class = "Garage"
    @active = false
    super

  setPhotoLimit: (limit) =>
    @photoLimit = limit

  setActive: (bool=true) =>
    @active = bool

  @fetch: (params) =>
    $("#loading").show()
    if tags = $("#tags-select").val()
      @previousTags or= []
      unless (@fetchedWithFilter && (tags.toString() == @previousTags.toString()))
        @page = 0
        @totalPhotos = null
      paramsData = () ->
        {page: page, tags: tags}
      @fetchedWithFilter = true
      @previousTags = tags
      @fetched = false
    else
      unless @fetched
        @page = 0
        @totalPhotos = null
      paramsData = () ->
        {page: page}
      @fetched = true
      @fetchedWithFilter = false

    page = @page + 1
    @page = page
    return false if (App.Garage.all().length == @totalPhotos)
    @totalPhotos = App.Garage.all().length

    params or=
      data: paramsData()
      processData: true

    @ajax().fetch(params)
