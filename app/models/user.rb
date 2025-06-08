class User < ApplicationRecord
  has_many :posts
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_posts, through: :bookmarks, source: :post
  has_one_attached :avatar

  validates :name, presence: true
  # validates :email, presence: true
  validates :uid, presence: true

  # 指定の投稿をブックマークに追加
  def bookmark(post)
    bookmarked_posts << post
  end

  # 指定の投稿のブックマークを解除
  def unbookmark(post)
    bookmarked_posts.destroy(post)
  end

  # 指定の投稿をすでにブックマークしているか？
  def bookmark?(post)
    bookmarked_posts.include?(post)
  end
end
