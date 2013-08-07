class App.Comment extends Spine.Model
  @configure 'Comment', 'message', 'username', 'id', 'commentable_id', 'commentable_type'
  @extend Spine.Model.Ajax

  @url: => "/api/v1/comments"

  @fetch: (params) =>
    params =
      data: {commentable_id: params.commentable_id, commentable_type: params.commentable_type.class }
      processData: true

    @ajax().fetch(params)
