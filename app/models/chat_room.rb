class ChatRoom < ApplicationRecord
  belongs_to :user1, class_name: "User", foreign_key: "user1_id"
  belongs_to :user2, class_name: "User", foreign_key: "user2_id"
  has_many :messages, dependent: :destroy

  def other_user(current_user)
    # user1_id, user2_id のどちらが current_user.id でないかを判定
    if user1 == current_user
      user2
    elsif user2 == current_user
      user1
    else
      nil
    end
  end
end
