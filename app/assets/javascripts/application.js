// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require select2
//= require app
//= require_tree .
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl

$(function() {
  $(".toggle-login").click(function(){
    $("#search-area").toggle();
    $("#tags-select").select2();
    if ($("#search-area").is(":visible")) {
      $(".feed").css("margin-top", 120);
    } else {
      $(".feed").css("margin-top", 0);
    }
    $(".register").toggle();
  });
  if ($("#app").length) {
    return new App({
      el: $("#app")
    });
  }
});
/// Uservoice
var uvOptions = {};
(function() {
  var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true;
  uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/RAA77sJ4WaNpJ6gVLfKSRA.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s);
})();

/// GA TRACKING
var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-37625111-1']);
  _gaq.push(['_trackPageview']);

(function() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
