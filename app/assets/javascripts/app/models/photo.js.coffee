class App.Photo extends Spine.Model
  @configure 'Photo', 'photo_url_thumb', 'photo_url_large'
  @extend Spine.Model.Ajax

  @fetch_with_limit: =>
    index  = @last()?.id or 0
    return false if index is @index
    @index = index

    params =
      data: {index: index}
      processData: true
    @ajax().fetch(params)