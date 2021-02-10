require 'test_helper'

class Admin::PhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_photos_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_photos_new_url
    assert_response :success
  end

end
