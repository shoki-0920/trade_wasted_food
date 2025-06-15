# app/mailers/chat_notification_mailer.rb
class ChatNotificationMailer < ApplicationMailer
  default from: "ueharattyo920@gmail.com"

  # チャット申請を受けた時の通知
  def chat_request_received(recipient_user, sender_user)
    @recipient = recipient_user
    @sender = sender_user
    @subject = "#{@sender.name}さんからチャット申請が届きました"

    mail(
      to: @recipient.email,
      subject: @subject
    )
  end

  # チャット申請が承認された時の通知
  def chat_request_approved(sender_user, recipient_user)
    @sender = sender_user
    @recipient = recipient_user
    @subject = "#{@recipient.name}さんがチャット申請を承認しました"

    mail(
      to: @sender.email,
      subject: @subject
    )
  end

  # 新しいチャットメッセージが送られてきた時の通知
  def new_message_received(recipient_user, sender_user, message)
    @recipient = recipient_user
    @sender = sender_user
    @message = message
    @subject = "#{@sender.name}さんから新しいメッセージが届きました"

    mail(
      to: @recipient.email,
      subject: @subject
    )
  end
end
