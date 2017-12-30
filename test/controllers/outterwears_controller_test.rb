require 'test_helper'

class OutterwearsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @outterwear = outterwears(:one)
  end

  test "should get index" do
    get outterwears_url
    assert_response :success
  end

  test "should get new" do
    get new_outterwear_url
    assert_response :success
  end

  test "should create outterwear" do
    assert_difference('Outterwear.count') do
      post outterwears_url, params: { outterwear: { active: @outterwear.active, description: @outterwear.description, favorite: @outterwear.favorite, name: @outterwear.name, outterwear_type_id: @outterwear.outterwear_type_id, picture: @outterwear.picture, style_type_id: @outterwear.style_type_id, temperature_type_id: @outterwear.temperature_type_id, user_id: @outterwear.user_id, weather_type_id: @outterwear.weather_type_id } }
    end

    assert_redirected_to outterwear_url(Outterwear.last)
  end

  test "should show outterwear" do
    get outterwear_url(@outterwear)
    assert_response :success
  end

  test "should get edit" do
    get edit_outterwear_url(@outterwear)
    assert_response :success
  end

  test "should update outterwear" do
    patch outterwear_url(@outterwear), params: { outterwear: { active: @outterwear.active, description: @outterwear.description, favorite: @outterwear.favorite, name: @outterwear.name, outterwear_type_id: @outterwear.outterwear_type_id, picture: @outterwear.picture, style_type_id: @outterwear.style_type_id, temperature_type_id: @outterwear.temperature_type_id, user_id: @outterwear.user_id, weather_type_id: @outterwear.weather_type_id } }
    assert_redirected_to outterwear_url(@outterwear)
  end

  test "should destroy outterwear" do
    assert_difference('Outterwear.count', -1) do
      delete outterwear_url(@outterwear)
    end

    assert_redirected_to outterwears_url
  end
end
