class AddUidAndProviderToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uid, :string, null: false
    add_column :users, :provider, :string, null: false

    add_index :users, [ :uid, :provider ], unique: true # 重複を防ぐためのユニークインデックス
  end
end
