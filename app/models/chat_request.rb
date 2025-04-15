class ChatRequest < ApplicationRecord
  # Userモデルを参照するように明示！
  belongs_to :requester, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :post

  scope :pending, -> { where(status: "pending") }
end
