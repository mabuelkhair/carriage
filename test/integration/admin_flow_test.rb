require 'test_helper'

class AdminFlowTest < ActionDispatch::IntegrationTest
  def setup
    @admin = User.create(username:"admin1", password:"123456789", email:"admin@test.com", role: "admin")
    @list = List.create(title: "test list",owner: @admin)
    @card = Card.create(owner: @admin, list: @list, title: "lorem ipsum", description: "lorem ipsum")
    # @current_user = users(:admin)
  end
  
  test "admin can login" do
    post "/login",
       params: { password:"123456789", email:"admin@test.com"} 
    assert_response :success
  end

  test "create list" do
    post "/admin/lists", headers:{"Authorization" => login},
       params: { list: {title:"first list"} } 
    assert_response :success

  end
  
  test "create card" do
    params = { card: {title:"first list", description: "card description"} }
    post "/admin/lists/#{@list.id}/cards", headers:{"Authorization" => login, 'CONTENT_TYPE' => 'application/json'},
       params:  params.to_json
    assert_response :success
  end
  
  test "create comment on card" do
    params = { comment: {content:"test comment"} }
    post "/admin/lists/#{@list.id}/cards/#{@card.id}/comments", headers:{"Authorization" => login, 'CONTENT_TYPE' => 'application/json'},
       params:  params.to_json
    assert_response :success
  end

  def login()
    post "/login",
       params: { password:"123456789", email:"admin@test.com"} 
    assert_response :success
    token = (JSON.parse @response.body)["auth_token"]
  end


end