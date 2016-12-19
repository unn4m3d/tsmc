require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get posts_index_url
    assert_response :success
  end

  test "should get new" do
    get posts_new_url
    assert_response :success
  end

  test "should get view" do
    get posts_view_url
    assert_response :success
  end

  test "should get update" do
    get posts_update_url
    assert_response :success
  end

  test "should get delete" do
    get posts_delete_url
    assert_response :success
  end

end
