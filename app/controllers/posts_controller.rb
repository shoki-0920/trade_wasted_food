class PostsController < ApplicationController
  def index
    if
      params[:fishing_spot_id].present?
      @fishing_spot = FishingSpot.find(params[:fishing_spot_id])
      @posts = @fishing_spot.posts.order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
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
      flash[:notice] = "投稿が更新されました"
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end



  private

  def post_params
    params.require(:post).permit(:title, :description, :price, :image, :fishing_spot_id)
  end
end
