class ChatRoomsController < ApplicationController
  before_action :set_chat_room

  def show
    @messages = @chat_room.messages.order(:created_at)
    @message = Message.new
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end
end
