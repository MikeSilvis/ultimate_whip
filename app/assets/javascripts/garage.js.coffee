# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#garage_make_id").change ->
    $("#garage_model_id").attr("disabled", false)
  $("#garage_model_id").change ->
    $("#garage_color_id").attr("disabled", false)
  $("#garage_color_id").change ->
    $("#garage_year").attr("disabled", false)