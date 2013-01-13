jQuery ->
  if $('#new_garage_photo').length
    $(document).bind "drop dragover", (e) ->
      e.preventDefault()
    $(document).bind "dragover", (e) ->
      dropZone = $("#dropzone")
      timeout = window.dropZoneTimeout
      unless timeout
        dropZone.addClass "in"
      else
        clearTimeout timeout
      if e.target is dropZone[0]
        dropZone.addClass "hover"
      else
        dropZone.removeClass "hover"
      window.dropZoneTimeout = setTimeout(->
        window.dropZoneTimeout = null
        dropZone.removeClass "in hover"
      , 100)

    $('#new_garage_photo').fileupload
      dropZone: $('#dropzone')
      dataType: "script"
      maxFileSize: 10000000
      add: (e, data) ->
        @numberOfFiles or= 0
        @numberOfFilesFinished or= 0
        @numberOfFiles++
        $("#photos").show()
        types = /(\.|\/)(gif|jpe?g|png)$/i
        file = data.files[0]
        if types.test(file.type) || types.test(file.name)
          data.submit()
        else
          alerts("error", "#{file.name} is not a gif, jpeg, or png image file")
      done: ->
        @numberOfFilesFinished++
        removeCounterIfComplete(@numberOfFiles, @numberOfFilesFinished)
        $(".progress .bar").css "width", uploadPercantage(@numberOfFiles, @numberOfFilesFinished)

    $("#finish-tagging").click ->
      $('.edit_garage_photo').submit()
      alerts("success", "Photos have been saved. Now <a href='/'>browse others!</a>")

uploadPercantage = (numberOfFiles, numberOfFilesFinished) ->
  ((numberOfFilesFinished / numberOfFiles) * 100) + "%"

allFilesUploaded = (numberOfFiles, numberOfFilesFinished) ->
  (numberOfFiles - numberOfFilesFinished)

removeCounterIfComplete = (numberOfFiles, numberOfFilesFinished) ->
  if allFilesUploaded(numberOfFiles, numberOfFilesFinished) == 0
    $(".progress").remove()
    $(".alert").remove()
    $("#finish-tagging").css("display":"block")
    alerts("success", "<strong>Congratulations!</strong> All your files have been uploaded.")

alerts = (type, message) ->
    $("#alert-js").append("<div class='alert alert-#{type}' id='files-uploaded-succesfully'>#{message}</div>")
    $(".alert").delay(10000).fadeOut 1000, ->
      $(this).remove()
