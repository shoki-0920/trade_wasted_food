class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc) # 新しい投稿を上に表示
  end
end