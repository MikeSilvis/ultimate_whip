$ ->
  uploader = new plupload.Uploader(
    runtimes: "html5"
    browse_button: "pickfiles"
    drop_element: "drop-area"
    container: "photo-upload"
    max_file_size: "5mb"
    url: "/photos"
    filters: [
      title: "Image files"
      extensions: "jpg,gif,png,jpeg"
    ]
    resize : {width : 1200, height : 900}
  )

  uploader.init()
  uploader.bind "FilesAdded", (up, files) ->
    window.upload_count = 0
    window.uploading_files = files
    if files.length > 20
      alerts("error", "<strong>SORRY!</strong> You can currently only upload 20 photos at once.")
    else
      $("#progress-area").append("<div class='progress progress-striped active' id='file-count'><div class='bar'></div></div>")
      uploader.start()

  uploader.bind "UploadProgress", (up, file) ->
    # $("#" + file.id + " b").html file.percent + "%"

  uploader.bind "Error", (up, err) ->
    $("body").append "<div>Error: " + err.code + ", Message: " + err.message + ((if err.file then ", File: " + err.file.name else "")) + "</div>"

  uploader.bind "FileUploaded", (up, file) ->
    upload_count++
    $(".bar").css("width": uploadPercantage())
    removeCounterIfComplete()
    App.Photo.fetch()

uploadPercantage = () ->
  ((upload_count / uploading_files.length) * 100) + "%"

allFilesUploaded = () ->
  (upload_count - uploading_files.length)

removeCounterIfComplete = () ->
  if allFilesUploaded() == 0
    $("#file-count").remove()
    alerts("success", "<strong>Congrats!</strong> All your files have been uploaded.")

alerts = (type, message) ->
    $("#alert-js").append("<div class='alert alert-#{type}' id='files-uploaded-succesfully'>#{message}</div>")
    $(".alert").delay(10000).fadeOut 1000, ->
      $(this).remove()