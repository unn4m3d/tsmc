require 'test_helper'

class ServersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get servers_index_url
    assert_response :success
  end

  test "should get show" do
    get servers_show_url
    assert_response :success
  end

end
