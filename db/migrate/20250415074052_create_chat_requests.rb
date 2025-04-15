class CreateChatRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_requests do |t|
      t.references :requester, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.references :post, null: false, foreign_key: true
      t.string :status, null: false, default: "pending"

      t.timestamps
    end
  end
end
