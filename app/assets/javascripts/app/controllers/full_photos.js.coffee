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
    FullPhoto.unbind "refresh"
    new App.Comments({el: $("#comments")}, @id)
    @listenEvents(@id)
    
  listenEvents: (id) =>
    $(".tags a").click (e)->
      e.preventDefault()
      tag = $(this).attr("data-tag").replace RegExp(" ", "g"), "-"
      $("#tags-select").find("##{tag}").attr("selected", true).change()
      $(".close").click()

alerts = (type, message) ->
    $("#alert-js").append("<div class='alert alert-#{type}' id='files-uploaded-succesfully'>#{message}</div>")
    $(".alert").delay(10000).fadeOut 1000, ->
      $(this).remove()