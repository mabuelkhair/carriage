require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @owner = User.create(username:"user1", password: "123123123", email: "mail@example.com")
    @card = Card.new(owner: @owner, list: @list, title: "lorem ipsum", description: "lorem ipsum")
  end
  test "should not save comment without content" do
    comment = Comment.new(card: @card, owner: @owner)
    assert_not comment.save, "Saved the card without content"
  end
  test "should not save comment without card" do
    comment = Comment.new(owner: @owner, content: "my first comment")
    assert_not comment.save, "Saved the card without content"
  end
  test "should not save comment without owner" do
    comment = Comment.new(card: @card, content: "my first comment")
    assert_not comment.save, "Saved the card without owner"
  end
  test "valid data" do
    comment = Comment.new(card: @card, owner: @owner,content: "my first comment")
    assert comment.save, "Deos not save valid comment"
  end
  test "add reply" do 
    comment = Comment.create(card: @card, owner: @owner,content: "my first comment")
    reply = Comment.new(comment: comment, card: @card, owner: @owner,content: "my first comment")
    assert reply.save, "deos not save replies"
  end
  test "should get parrent comment of reply" do 
    comment = Comment.create(card: @card, owner: @owner,content: "my first comment")
    reply = Comment.create(comment: comment, card: @card, owner: @owner,content: "my first comment")
    assert_equal( reply.comment, comment, "wrong reply parrent")
  end
  test "should get replies on comment" do 
    comment = Comment.create(card: @card, owner: @owner,content: "my first comment")
    Comment.create(comment: comment, card: @card, owner: @owner,content: "comment two")
    Comment.create(comment: comment, card: @card, owner: @owner,content: "comment three")
    assert_equal( 2, comment.replies.count, "wrong number of replies")
  end

end
