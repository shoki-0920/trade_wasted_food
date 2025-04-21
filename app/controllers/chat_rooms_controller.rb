class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [ :show ]

  # チャットルームの一覧
  def index
    @chat_rooms = ChatRoom
      .where("user1_id = :id OR user2_id = :id", id: current_user.id)
      .includes(:user1, :user2)  # n+1問題を防ぐ
  end

  # チャットルームの詳細
  def show
    @messages = @chat_room.messages.order(:created_at)
    @message = Message.new
  end

  # 新しいチャットルーム作成
  def create
    @chat_room = ChatRoom.find_by(user1: current_user, user2: params[:user_id]) ||
                 ChatRoom.find_by(user1: params[:user_id], user2: current_user)

    # 既存のチャットルームがなければ新しく作成
    unless @chat_room
      @chat_room = ChatRoom.create(user1: current_user, user2: User.find(params[:user_id]))
    end

    # 作成後、チャットルームに遷移
    redirect_to chat_room_path(@chat_room)
  end

  def destroy
    @chat_room = ChatRoom.find(params[:id])

    if @chat_room.user1 == current_user || @chat_room.user2 == current_user
      @chat_room.destroy
      redirect_to chat_rooms_path, notice: "チャットを削除しました"
    else
      redirect_to chat_room_path, alert: "削除権限がありません"
    end
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end
end
