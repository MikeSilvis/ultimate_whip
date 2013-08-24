#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

class App extends Spine.Controller
  constructor: ->
    super
    @current_user = new App.CurrentUser({el: @el})

window.App = App
window.Domain = window.location.host


$ ->
  window.LoaderSrc = $("#loading img").attr('src')

String::seoName = () ->
  this.valueOf().replace(RegExp(" ", "g"), "-").toLowerCase()
