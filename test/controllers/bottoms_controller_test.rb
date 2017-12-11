require 'test_helper'

class BottomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bottom = bottoms(:one)
  end

  test "should get index" do
    get bottoms_url
    assert_response :success
  end

  test "should get new" do
    get new_bottom_url
    assert_response :success
  end

  test "should create bottom" do
    assert_difference('Bottom.count') do
      post bottoms_url, params: { bottom: { active: @bottom.active, bottom_type_id: @bottom.bottom_type_id, description: @bottom.description, favorite: @bottom.favorite, name: @bottom.name, picture: @bottom.picture, style_type_id: @bottom.style_type_id, user_id: @bottom.user_id, weather_id: @bottom.weather_id } }
    end

    assert_redirected_to bottom_url(Bottom.last)
  end

  test "should show bottom" do
    get bottom_url(@bottom)
    assert_response :success
  end

  test "should get edit" do
    get edit_bottom_url(@bottom)
    assert_response :success
  end

  test "should update bottom" do
    patch bottom_url(@bottom), params: { bottom: { active: @bottom.active, bottom_type_id: @bottom.bottom_type_id, description: @bottom.description, favorite: @bottom.favorite, name: @bottom.name, picture: @bottom.picture, style_type_id: @bottom.style_type_id, user_id: @bottom.user_id, weather_id: @bottom.weather_id } }
    assert_redirected_to bottom_url(@bottom)
  end

  test "should destroy bottom" do
    assert_difference('Bottom.count', -1) do
      delete bottom_url(@bottom)
    end

    assert_redirected_to bottoms_url
  end
end
