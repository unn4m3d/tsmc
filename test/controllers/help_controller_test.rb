require 'test_helper'

class HelpControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get help_index_url
    assert_response :success
  end

  test "should get commandbook" do
    get help_commandbook_url
    assert_response :success
  end

  test "should get worldguard" do
    get help_worldguard_url
    assert_response :success
  end

  test "should get craftbook" do
    get help_craftbook_url
    assert_response :success
  end

  test "should get faq" do
    get help_faq_url
    assert_response :success
  end

end
