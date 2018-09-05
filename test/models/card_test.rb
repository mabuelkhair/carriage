require 'test_helper'

class CardTest < ActiveSupport::TestCase
  def setup
    @owner = User.create(username:"user1", password: "123123123", email: "mail@example.com")
    @list = List.new(title: "first list",owner: @owner)
  end
  test "should not save card without title" do
    card = Card.new(owner: @owner, list: @list, description: "lorem ipsum")
    assert_not card.save, "Saved the card without a title"
  end

  test "should not save card without description" do
    card = Card.new(owner: @owner, list: @list, title: "lorem ipsum")
    assert_not card.save, "Saved the card without a description"
  end

  test "should not save card without list" do
    card = Card.new(owner: @owner, title: "lorem ipsum", description: "lorem ipsum")
    assert_not card.save, "Saved the card without a list"
  end

  test "should not save card without owner" do
    card = Card.new(list: @list, title: "lorem ipsum", description: "lorem ipsum")
    assert_not card.save, "Saved the card without a owner"
  end

  test "valid data" do
    card = Card.new(owner: @owner, list: @list, title: "lorem ipsum", description: "lorem ipsum")
    assert card.save, "deos not save valid card"
  end

end
