class App.Photo extends Spine.Model
  @configure 'Photo', 'photo_url_thumb', 'tags_string'
  @extend Spine.Model.Ajax

  @fetch: (params) =>
    if tags = $("#tags-select").val()
      @previousTags or= []
      unless (@fetchedWithFilter && (tags.toString() == @previousTags.toString()))
        @page = 0
        @totalPhotos = null
        #$("#photo_container").html("")
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
    return false if (App.Photo.all().length == @totalPhotos)
    @totalPhotos = App.Photo.all().length

    params or=
      data: paramsData()
      processData: true

    @ajax().fetch(params)
