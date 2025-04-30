class User < ApplicationRecord
  has_many :posts
  has_one_attached :avatar

  validates :name, presence: true
  # validates :email, presence: true
  validates :uid, presence: true
end
