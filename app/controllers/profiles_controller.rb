class ProfilesController < ApplicationController
  before_action :ensure_logged_in

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to posts_path, notice: "プロフィールを更新しました！"
    else
      render :edit, alert: "更新に失敗しました"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def ensure_logged_in
    unless current_user
      flash[:alert] = "ログインしてください"
      redirect_to root_path
    end
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :bio, :location, :avatar)
  end
end
