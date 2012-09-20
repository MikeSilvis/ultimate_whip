$ ->
  uploader = new plupload.Uploader(
    runtimes: "html5"
    browse_button: "pickfiles"
    drop_element: "drop-area"
    container: "photo-upload"
    max_file_size: "10mb"
    url: "/photos"
    filters: [
      title: "Image files"
      extensions: "jpg,gif,png,jpeg"
    ]
  )

  uploader.init()
  uploader.bind "FilesAdded", (up, files) ->
    $("#photo-upload").append("<div id='file-count'><span id='uploaded'>0</span> of <span id='total'>#{files.length}</span></div>")
    window.uploading_files = files
    uploader.start()

  uploader.bind "UploadProgress", (up, file) ->
    # $("#" + file.id + " b").html file.percent + "%"

  uploader.bind "Error", (up, err) ->
    $("body").append "<div>Error: " + err.code + ", Message: " + err.message + ((if err.file then ", File: " + err.file.name else "")) + "</div>"

  uploader.bind "FileUploaded", (up, file) ->
    $("#uploaded").text(addOneToFileUploadcount)
    removeCounterIfComplete()
    App.Photo.fetch()

addOneToFileUploadcount = () ->
  (parseInt(($("#uploaded").text())) + 1)

currentFileCount = () ->
  parseInt(($("#uploaded").text()))

totalFileCount = () ->
  parseInt(($("#total").text()))

allFilesUploaded = () ->
  (currentFileCount() - totalFileCount())

removeCounterIfComplete = () ->
  if allFilesUploaded() == 0
    $("#file-count").remove()
    $("#alert-js").append('<div class="alert alert-success" id="files-uploaded-succesfully"><strong>Congrats!</strong> All your files have been uploaded.</div>')
    $(".alert").delay(10000).fadeOut 1000, ->
      $(this).remove()
