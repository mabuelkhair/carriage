require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "should not save user without data" do
    print @user.inspect
    user = User.new
    assert_not user.save, "Saved the user without data"
  end

  test "valid data" do
    user = User.new(username:"user1", password:"123456789", email:"mail@test.com")
    assert user.save, "does not save the user with valid data"
  end

  test "should not save user with any missing param " do
    user = User.new(password:"123456789", email:"mail@test.com")
    assert_not user.save, "Saved the user without username"
    user = User.new(username:"user1", email:"mail@test.com")
    assert_not user.save, "Saved the user without password"
    user = User.new(username:"user1", password:"123456789")
    assert_not user.save, "Saved the user without email"
  end

  test "member is default role" do
    user = User.new(username:"user1", password:"123456789", email:"mail@test.com")
    assert_equal('member',user.role,"Default role value is not member")
  end

  test "member is role posible values" do
    user = User.new(username:"user1", password:"123456789", email:"mail@test.com")
    assert_equal('member',user.role,"Default role value is not member")
    assert_raises('ArgumentError'){ user.role="not_a_role" }
    assert user.role = "admin", "does not accept admin role"
    assert user.role = "member", "does not accept member role"
  end

  test "validate uniquness" do
    User.create(username:"user1", password:"123456789", email:"mail@test.com")
    user = User.new(username:"user2", password:"123456789", email:"mail@test.com")
    assert_not user.save, "Saved the user with duplicate email"

    user = User.new(username:"user1", password:"123456789", email:"mail2@test.com")
    assert_not user.save, "Saved the user with duplicate username"

  end

  test "test invalid email" do
    user = User.new(username:"user1", password:"123456789", email:"invalidemail")
    assert_not user.save, "saved invalid email"
    user = User.new(username:"user1", password:"123456789", email:"invalid@email")
    assert_not user.save, "saved invalid email"
  end
end
