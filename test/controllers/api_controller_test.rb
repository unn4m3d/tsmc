require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get join" do
    get api_join_url
    assert_response :success
  end

  test "should get has_joined" do
    get api_has_joined_url
    assert_response :success
  end

  test "should get auth" do
    get api_auth_url
    assert_response :success
  end

end
