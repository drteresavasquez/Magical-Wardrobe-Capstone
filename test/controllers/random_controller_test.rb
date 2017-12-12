require 'test_helper'

class RandomControllerTest < ActionDispatch::IntegrationTest
  test "should get outfit" do
    get random_outfit_url
    assert_response :success
  end

  test "should get clothes" do
    get random_clothes_url
    assert_response :success
  end

end
