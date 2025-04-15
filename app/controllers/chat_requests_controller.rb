class ChatRequestsController < ApplicationController
  def create
    # 新しいチャット申請を作成
    @chat_request = ChatRequest.new(chat_request_params)
    @chat_request.requester = current_user  # ログイン中のユーザーがリクエスター
    @chat_request.status = "pending"  # 最初は承認待ち（保留中）

    if @chat_request.save
      # 成功した場合、投稿詳細ページにリダイレクト
      redirect_to @chat_request.post, notice: "チャット申請が送信されました。"
    else
      # 失敗した場合、投稿詳細ページに戻る
      redirect_to @chat_request.post, alert: "チャット申請の送信に失敗しました。"
    end
  end

  def approve
    @chat_request = ChatRequest.find(params[:id])
    # 申請のステータスを'approved'に変更
    @chat_request.update(status: "approved")
    # チャットルームを作成
    @chat_room = ChatRoom.create(user1: @chat_request.requester, user2: @chat_request.receiver)
    # 承認後、投稿詳細ページにリダイレクト
    redirect_to @chat_room, notice: "チャット申請が承認されました。"
  end

  def reject
    @chat_request = ChatRequest.find(params[:id])
    # 申請のステータスを'rejected'に変更
    @chat_request.update(status: "rejected")
    # 拒否後、投稿詳細ページにリダイレクト
    redirect_to @chat_request.post, notice: "チャット申請が拒否されました。"
  end


  private

  def chat_request_params
    # 必要なパラメータ（post_id と receiver_id）を受け取る
    params.require(:chat_request).permit(:post_id, :receiver_id)
  end
end
