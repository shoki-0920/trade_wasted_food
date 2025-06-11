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
    return if bookmark?(post) # 既にブックマーク済みなら何もしない
    bookmarks.create(post: post)
  end

  # 指定の投稿のブックマークを解除
  def unbookmark(post)
    bookmarks.find_by(post: post)&.destroy
  end

  # 指定の投稿をすでにブックマークしているか？
  def bookmark?(post)
    bookmarks.exists?(post: post)
  end
end
