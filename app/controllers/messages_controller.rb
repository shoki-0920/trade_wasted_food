class MessagesController < ApplicationController
  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @message = @chat_room.messages.build(message_params)
    @message.user = current_user

    if @message.save
      # 📧 新しいメッセージ受信の通知メールを送信
      # 相手を特定（user1かuser2のうち、current_userじゃない方）
      recipient = @chat_room.user1 == current_user ? @chat_room.user2 : @chat_room.user1

      ChatNotificationMailer.new_message_received(
        recipient,     # メッセージを受け取る人
        current_user,  # メッセージを送った人
        @message       # 送信されたメッセージ
      ).deliver_now

      redirect_to chat_room_path(@chat_room)
    else
      @messages = @chat_room.messages.order(:created_at)
      render "chat_rooms/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
