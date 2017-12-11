require 'test_helper'

class FootwearsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @footwear = footwears(:one)
  end

  test "should get index" do
    get footwears_url
    assert_response :success
  end

  test "should get new" do
    get new_footwear_url
    assert_response :success
  end

  test "should create footwear" do
    assert_difference('Footwear.count') do
      post footwears_url, params: { footwear: { active: @footwear.active, description: @footwear.description, favorite: @footwear.favorite, footwear_type_id: @footwear.footwear_type_id, name: @footwear.name, picture: @footwear.picture, style_type_id: @footwear.style_type_id, user_id: @footwear.user_id, weather_type_id: @footwear.weather_type_id } }
    end

    assert_redirected_to footwear_url(Footwear.last)
  end

  test "should show footwear" do
    get footwear_url(@footwear)
    assert_response :success
  end

  test "should get edit" do
    get edit_footwear_url(@footwear)
    assert_response :success
  end

  test "should update footwear" do
    patch footwear_url(@footwear), params: { footwear: { active: @footwear.active, description: @footwear.description, favorite: @footwear.favorite, footwear_type_id: @footwear.footwear_type_id, name: @footwear.name, picture: @footwear.picture, style_type_id: @footwear.style_type_id, user_id: @footwear.user_id, weather_type_id: @footwear.weather_type_id } }
    assert_redirected_to footwear_url(@footwear)
  end

  test "should destroy footwear" do
    assert_difference('Footwear.count', -1) do
      delete footwear_url(@footwear)
    end

    assert_redirected_to footwears_url
  end
end
