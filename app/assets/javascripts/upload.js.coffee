jQuery ->
  if $("#dropzone").length
    window.dropZone = $("#dropzone")
    window.upload = new FileUpload
    new BindDropzone

  if $(".manage").length
    new BindDetePhoto
    new BindSelect2

class FileUpload
  constructor: ->
    @numberOfFiles or= 0
    @numberOfFilesFinished or= 0
    @linkButtonToUpload()
    @uploadFile()

  linkButtonToUpload: =>
    $(".upload-button").click (e) ->
      e.preventDefault()
      $("#garage_photo_photo").click()

  uploadFile: =>
    $('#new_garage_photo').fileupload
      dropZone: dropZone
      dataType: "json"
      maxFileSize: 10000000
      add: (e, data) =>
        types = /(\.|\/)(jpe?g|png)$/i
        file = data.files[0]
        if types.test(file.type) || types.test(file.name)
          data.submit()
          @numberOfFiles++
        else
          new Flash "error", "#{file.name} is not a jpeg, or png image file"
      progress: (e, data) =>
        @updateProgressBar()
      done: =>
        @updateProgressBar()

  updateProgressBar: =>
    @numberOfFilesFinished += .5
    @progressBar((@numberOfFilesFinished / @numberOfFiles) * 100)
    if @numberOfFilesFinished == @numberOfFiles
      new Flash 'success', "All photos uploaded. <a href='/photos'>View them here.</a>"

  progressBar: (percentage=5) =>
    $(".progress").show()
    $(".progress .bar").css "width", "#{percentage}%"

class BindDropzone
  constructor: ->
    description = dropZone.find("h1").first()
    currentText = description.text()
    $(document).bind "dragover", (e) ->
      e.preventDefault()
      description.text "Drop files here to start uploading"
    $(document).bind 'drop', (e) ->
      description.text currentText
      e.preventDefault()

class BindDetePhoto
  constructor: ->
    @bindDeleteImage()
    @bindThumbnailImage()
    @bindThumbanilClick()

  bindDeleteImage: =>
    $(".delete-image").hover (->
      $(this).show()
      $('.delete-image').prev().addClass 'thumbnail-hover'
    ), ->
      $(this).hide()
      $('.delete-image').prev().removeClass 'thumbnail-hover'

  bindThumbnailImage: =>
    $(".thumbnail").hover (->
      $(".delete-image").insertAfter $(this)
      $(".delete-image").css
        display: "block"
        position: "absolute"
        top: $(this).offset().top + 10
        left: $(this).offset().left + 9
    ), ->
      $(".delete-image").hide()

  bindThumbanilClick: =>
    $(".thumbnail").bind 'click taphold', (e) =>
      box = confirm 'are you sure you wish to delete?'
      @deletePhoto($(e.currentTarget)) if box == true
    $('.delete-image').bind 'click taphold', (e) =>
      box = confirm 'are you sure you wish to delete?'
      @deletePhoto($(e.currentTarget).prev()) if box == true

  deletePhoto: ($photo) =>
    $('.delete-image').hide()
    $photo.next().next().val('true')
    $('form').submit()
    $photo.next().next().remove() ## delete the delete field
    $photo.next().next().remove() ## delete the attributes field
    $photo.remove() ## Delete the image
    new Flash 'success', "Photo successfully deleted"

class BindSelect2
  constructor: ->
    tags = JSON.parse($(".current_tokens").attr("data-tokens"))
    $("input.string").select2({tags:tags, tokenSeparators: [","]}).change ->
      $('form').submit()
      new Flash 'success', "Tags successfully updated"

class Flash
  constructor: (type, message) ->
    $(".alert").remove()
    $("#alert-js").html "<div class='alert alert-#{type}' id='files-uploaded-succesfully'><button type='button' class='close'>&times;</button>#{message}</div>"
    new ShowFlash(0)
