require "test_helper"

class FishingSpotsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get fishing_spots_show_url
    assert_response :success
  end
end
