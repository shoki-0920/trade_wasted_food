# app/controllers/bookmarks_controller.rb
class BookmarksController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    current_user.bookmark(@post)
    # リダイレクトはしない
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.unbookmark(@post)
    # こちらもリダイレクトしない
  end
end
