require 'test_helper'

class Admin::MealsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_meals_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_meals_edit_url
    assert_response :success
  end

end
