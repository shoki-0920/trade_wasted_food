require "test_helper"

class ChatRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get chat_requests_create_url
    assert_response :success
  end

  test "should get approve" do
    get chat_requests_approve_url
    assert_response :success
  end

  test "should get reject" do
    get chat_requests_reject_url
    assert_response :success
  end
end
