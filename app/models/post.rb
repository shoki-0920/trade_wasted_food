class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :fishing_spot

  has_many :chat_requests, dependent: :destroy

end
