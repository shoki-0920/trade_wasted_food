module ChatRoomsHelper
  def existing_chat_room?(user_a, user_b)
    ChatRoom.exists?(user1: user_a, user2: user_b) || ChatRoom.exists?(user1: user_b, user2: user_a)
  end
end
