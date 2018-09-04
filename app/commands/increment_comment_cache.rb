class IncrementCommentCache
  prepend SimpleCommand

  def initialize(comment)
    @comment = comment
  end

  def call
    comments = $redis.hgetall("comments")
    counter = 1
    counter = comments[@comment.card_id.to_s].to_i + 1 if comments.key?(@comment.card_id.to_s)
    comments[@comment.card_id.to_s] = counter
    $redis.mapped_hmset "comments", comments
  end

end