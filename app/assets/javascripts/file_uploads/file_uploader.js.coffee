$ ->
  uploader = new plupload.Uploader(
    runtimes: "html5"
    browse_button: "pickfiles"
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
    $.each files, (i, file) ->
      $("body").append "<div id=\"" + file.id + "\">" + file.name + " (" + plupload.formatSize(file.size) + ") <b></b>" + "</div>"
    uploader.start()

  uploader.bind "UploadProgress", (up, file) ->
    $("#" + file.id + " b").html file.percent + "%"

  uploader.bind "Error", (up, err) ->
    $("body").append "<div>Error: " + err.code + ", Message: " + err.message + ((if err.file then ", File: " + err.file.name else "")) + "</div>"

  uploader.bind "FileUploaded", (up, file) ->
    App.Photo.fetch()