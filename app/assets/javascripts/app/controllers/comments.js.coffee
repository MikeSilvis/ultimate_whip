Comment = App.Comment
alreadyFetched = {}

class App.Comments extends Spine.Controller
  events:
    "keydown .new-comment" : "addComment"

  constructor: ->
    super
    Comment.bind 'refresh change', @render
    if @alreadyFetched()
      @render()
    else
      Comment.fetch({commentable_id: @object.id, commentable_type: @object})
      @setAlreadyFetched()

  alreadyFetched: =>
    alreadyFetched["#{@object.id}-#{@object.class}"]

  setAlreadyFetched: (bool = true) =>
    alreadyFetched["#{@object.id}-#{@object.class}"] = bool

  render: =>
    @html @view('comments/show')(comments: @allCommentsForObject())
    #$("#comments-area").css("max-height":@commentsAreaHeight()).scrollTop(11000)

  allCommentsForObject: =>
    _.where Comment.all(),
      commentable_id: @object.id
      commentable_type: @object.class

  addComment: (e) =>
    e.stopPropagation()
    if e.keyCode is 13 && @el.find(".new-comment").val().length > 1
      App.Comment.create(message: @el.find(".new-comment").val(), commentable_id: @object.id, username: $("meta[name=user-username]").attr("content"), commentable_type: @object.class)
      $(".new-comment").val("")

  #commentsAreaHeight: =>
    #($(".mikes-modal").height() * .58) - 10
