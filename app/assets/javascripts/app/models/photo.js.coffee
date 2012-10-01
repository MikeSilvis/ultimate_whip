class App.Photo extends Spine.Model
  @configure 'Photo', 'photo_url_thumb'
  @extend Spine.Model.Ajax

  @fetch: (params) =>
    if $("#tags-select").val()
      @index = null unless @fetchedWithFilter
      paramsData = () ->
        {index: index, tags: $("#tags-select").val().join(",")}
      @fetchedWithFilter = true
    else
      paramsData = () ->
        {index: index}
    index  = @first()?.id
    return false if index is @index and index
    @index = index

    params or=
      data: paramsData()
      processData: true

    @ajax().fetch(params)