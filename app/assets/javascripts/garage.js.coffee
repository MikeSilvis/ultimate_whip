# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#garage_model_id").prepend("<option value='default'>Select your vehicle</option>").val("default")
  $("#garage_model_id").change ->
    $("#garage_color_id").attr("disabled", false).select2()
  $("#garage_color_id").change ->
    $("#garage_year").attr("disabled", false).select2()
  $("#garage_color_id, #garage_year,#garage_model_id").select2()
  $("#garage_year").select2("disable")

  if $(".garage_tags").length
    tags = JSON.parse($(".current_tokens").attr("data-tokens"))
    $(".garage_tags").select2({tags:tags, tokenSeparators: [","]})
    $(".garage_photo_tags").select2({tags:tags, tokenSeparators: [","]})
