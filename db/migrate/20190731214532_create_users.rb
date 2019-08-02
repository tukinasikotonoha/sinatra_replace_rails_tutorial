class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## 追加した情報
      t.string :nickname,              null: false, default: ""
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps
      # ユーザー画像
      t.string   :image
    end
  end
end
