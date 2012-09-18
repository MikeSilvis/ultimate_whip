jQuery ->
  $(".login-form").click (e) ->
    e.stopPropagation()
  $(".log-me-in").click ->
    $("#user_email").focus()