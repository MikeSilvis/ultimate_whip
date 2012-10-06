class App.Comment extends Spine.Model
  @configure 'Comment', 'message', 'username', 'id', 'created_at_in_words', 'commentable_id'
  @extend Spine.Model.Ajax

  @fetch: (params) =>
    params =
      data: {commentable_id: params.commentable_id}
      processData: true

    @ajax().fetch(params)