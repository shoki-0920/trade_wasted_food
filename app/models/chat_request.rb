class ChatRequest < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :post

  scope :pending, -> { where(status: "pending") }

  validates :requester_id, uniqueness: {
    scope: [ :receiver_id, :post_id ],
    message: "はすでに申請済みです（承認待ち）"
  }, if: :pending?

  def pending?
    status == "pending"
  end
end
