class ProfilesController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました！"
      redirect_to posts_path  # 更新後のリダイレクト先（適宜変更）
    else
      flash.now[:alert] = "プロフィールの更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :bio, :location, :avatar)
  end
end
