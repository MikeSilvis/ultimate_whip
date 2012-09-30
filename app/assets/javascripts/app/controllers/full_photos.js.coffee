FullPhoto = App.FullPhoto

class App.FullPhotos extends Spine.Controller

  constructor: (id)->
    super
    @id = id
    FullPhoto.bind 'refresh', @render
    FullPhoto.fetch({id: @id})

  render: =>
    $("#modal-container").html(@view('full_photos/index')(FullPhoto.find(@id)))
    $("#mikes-modal").mikesModal()
    @listenEvents(@id)

  listenEvents: (id) =>
    $(".close").click ->
      FullPhoto.unbind "refresh"
    $(".tags a").click (e)->
      e.preventDefault()
      $("#tags-select").find("##{$(this).attr("data-tag")}").attr("selected", true).trigger("liszt:updated")
      # App.FullPhoto.deleteAll()
      # App.FullPhoto.fetch()
      $(".close").click()
    $(".new-comment").keyup (e) ->
      if e.keyCode is 13
        e.preventDefault()
        App.Comment.create message: $(".new-comment").val(), commentable_id: id
        $(".new-comment").val("")
        FullPhoto.fetchSingle({id: id})

alerts = (type, message) ->
    $("#alert-js").append("<div class='alert alert-#{type}' id='files-uploaded-succesfully'>#{message}</div>")
    $(".alert").delay(10000).fadeOut 1000, ->
      $(this).remove()