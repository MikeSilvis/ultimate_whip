Comment = App.Comment

class App.Comments extends Spine.Controller
  events:
    "keydown .new-comment" : "addComment"

  constructor: ->
    super
    Comment.deleteAll()
    Comment.fetch({commentable_id: @object.id, commentable_type: @object})
    Comment.bind 'refresh change', @render


  render: =>
    @html @view('comments/show')(comments: Comment.all())
    #$("#comments-area").css("max-height":@commentsAreaHeight()).scrollTop(11000)

  addComment: (e) =>
    e.stopPropagation()
    if e.keyCode is 13 && $(".new-comment").val().length > 1
      App.Comment.create(message: $(".new-comment").val(), commentable_id: @object.id, username: $("meta[name=user-username]").attr("content"), commentable_type: @object.class)
      $(".new-comment").val("")

  #commentsAreaHeight: =>
    #($(".mikes-modal").height() * .58) - 10
