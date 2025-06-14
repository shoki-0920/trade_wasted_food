class PostsController < ApplicationController
def index
  # 基本のクエリを設定（N+1問題対策）
  @posts = Post.includes(:fishing_spot, :user, image_attachment: :blob)

  # 釣り場での絞り込み
  if params[:fishing_spot_id].present?
    @fishing_spot = FishingSpot.find(params[:fishing_spot_id])
    @posts = @posts.where(fishing_spot_id: params[:fishing_spot_id])
  end

  # キーワード検索
  if params[:search].present?
    @posts = @posts.where("title ILIKE ? OR description ILIKE ?",
                         "%#{params[:search]}%", "%#{params[:search]}%")
  end

  # 価格帯での絞り込み
  if params[:price_range].present?
  min_price, max_price = params[:price_range].split("-").map(&:to_i)

  if max_price > 0
    @posts = @posts.where(price: min_price..max_price)
  else
    @posts = @posts.where("price >= ?", min_price)
  end
  end

  # 最終的にソート
  @posts = @posts.order(created_at: :desc)
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

  def bookmarks
    @posts = current_user.bookmarked_posts
  end

  def preview
  if params[:id]
    # 編集時のプレビュー
    @post = Post.find(params[:id])

    unless @post.user == current_user
      redirect_to posts_path, alert: "権限がありません"
      return
    end

    @post.assign_attributes(post_params)
    @edit_mode = true
    @post_id = params[:id]
  else
    # 新規作成時のプレビュー
    @post = Post.new(post_params)
    if params[:post][:image].present?
      @post.image.attach(params[:post][:image])
    end
    @post.user = current_user
    @edit_mode = false
  end

  # 関連データの読み込み
  if @post.fishing_spot_id.present?
    @post.fishing_spot = FishingSpot.find(@post.fishing_spot_id)
  end

  @post.valid?

  respond_to do |format|
    format.html { render :preview }  # 従来の画面遷移版
    format.turbo_stream  # TurboStream版
  end
  end


  private

  def post_params
    params.require(:post).permit(:title, :description, :price, :image, :fishing_spot_id)
  end
end
