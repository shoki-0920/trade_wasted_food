class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc) # 新しい投稿を上に表示
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path, notice: "投稿完了しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to posts_path, alert: "権限がありません" unless @post.user == current_user
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = '投稿が更新されました'
      redirect_to @post
    else
      render :edit
    end
  end



  private

  def post_params
    params.require(:post).permit(:title, :description, :price, :image)
  end
end
