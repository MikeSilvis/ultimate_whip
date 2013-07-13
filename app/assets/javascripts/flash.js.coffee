jQuery ->
  if $(".alert").length
    new ShowFlash()

class window.ShowFlash
  constructor: (initialDelay = 1200) ->
    $(".alert").delay(initialDelay).slideDown("slow")
    setTimeout (->
      $(".alert").slideUp("slow")
    ), 8000
    $(".alert .close").click ->
      $(".alert").slideUp("slow")

