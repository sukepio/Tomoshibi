require 'test_helper'

class Admin::AdminEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_admin_events_index_url
    assert_response :success
  end
end
