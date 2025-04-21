require "test_helper"

class ChatRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    skip
    get chat_rooms_show_url
    assert_response :success
  end
end
