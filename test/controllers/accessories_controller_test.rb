require 'test_helper'

class AccessoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @accessory = accessories(:one)
  end

  test "should get index" do
    get accessories_url
    assert_response :success
  end

  test "should get new" do
    get new_accessory_url
    assert_response :success
  end

  test "should create accessory" do
    assert_difference('Accessory.count') do
      post accessories_url, params: { accessory: { accessory_type_id: @accessory.accessory_type_id, active: @accessory.active, description: @accessory.description, favorite: @accessory.favorite, name: @accessory.name, picture: @accessory.picture, style_type_id: @accessory.style_type_id, user_id: @accessory.user_id, weather_type_id: @accessory.weather_type_id } }
    end

    assert_redirected_to accessory_url(Accessory.last)
  end

  test "should show accessory" do
    get accessory_url(@accessory)
    assert_response :success
  end

  test "should get edit" do
    get edit_accessory_url(@accessory)
    assert_response :success
  end

  test "should update accessory" do
    patch accessory_url(@accessory), params: { accessory: { accessory_type_id: @accessory.accessory_type_id, active: @accessory.active, description: @accessory.description, favorite: @accessory.favorite, name: @accessory.name, picture: @accessory.picture, style_type_id: @accessory.style_type_id, user_id: @accessory.user_id, weather_type_id: @accessory.weather_type_id } }
    assert_redirected_to accessory_url(@accessory)
  end

  test "should destroy accessory" do
    assert_difference('Accessory.count', -1) do
      delete accessory_url(@accessory)
    end

    assert_redirected_to accessories_url
  end
end
