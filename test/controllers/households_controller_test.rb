require 'test_helper'

class HouseholdsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get households_new_url
    assert_response :success
  end

  test "should get create" do
    get households_create_url
    assert_response :success
  end

  test "should get update" do
    get households_update_url
    assert_response :success
  end

end
