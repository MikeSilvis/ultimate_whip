Comment = App.Comment

class App.Comments extends Spine.Controller
  events:
    "keyup .new-comment" : "addComment"

  constructor: (el, commentable_id) ->
    super
    @commentable_id = commentable_id
    Comment.fetch({commentable_id: @commentable_id})
    Comment.bind 'refresh change', @render


  render: =>
    comments = Comment.all()
    @html @view('comments/show')(comments: comments)
    $("#comments-area").scrollTop(11000)

  addComment: (e) =>
    if e.keyCode is 13
      App.Comment.create message: $(".new-comment").val(), commentable_id: @commentable_id, username: $("meta[name=user-username]").attr("content"), created_at_in_words: "just now"
      $(".new-comment").val("")
    else
      currentHeight = $(".new-comment").height()
      $(".new-comment").height(currentHeight + 15) if ($(".new-comment").val().length % 33 == 0)