class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :fishing_spot

  has_many :chat_requests, dependent: :destroy


  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
