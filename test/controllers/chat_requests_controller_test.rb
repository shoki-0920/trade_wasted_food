require "test_helper"

class ChatRequestsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @chat_request = chat_requests(:one)
    @post = posts(:one)
    @receiver = users(:one)
  end

  test "should create chat request" do
    post chat_requests_url, params: { chat_request: { post_id: @post.id, receiver_id: @receiver.id } }
    assert_response :redirect
  end

  test "should approve chat request" do
    post approve_chat_request_url(@chat_request)
    assert_response :redirect
  end

  test "should reject chat request" do
    post reject_chat_request_url(@chat_request)
    assert_response :redirect
  end
end
