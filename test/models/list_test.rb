require 'test_helper'

class ListTest < ActiveSupport::TestCase
    def setup
        @owner = User.create(username:"user1", password: "123123123", email: "mail@example.com")
    end
    test "should not save list without title" do
      list = List.new(owner: @owner)
      assert_not list.save, "Saved the list without a title"
    end

    test "should not save list without owner" do
      list = List.new(title: "first list")
      assert_not list.save, "Saved the list without owner"
    end

    test "valid data" do
      list = List.new(title: "first list",owner: @owner)
      assert list.save, "does not save the list with valid data"

    end

end
