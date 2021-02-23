require 'test_helper'

class Public::ResidentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_residents_show_url
    assert_response :success
  end
end
