require 'test_helper'

class HamperControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hamper_index_url
    assert_response :success
  end

end
