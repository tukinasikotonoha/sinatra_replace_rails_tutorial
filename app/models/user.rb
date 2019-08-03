class User < ApplicationRecord
  before_save { self.email = email.downcase } #email属性を小文字に変換してメールアドレスの一意性を保証する
  # 登録時のバリデーション
  validates :nickname, presence: true, length: { maximum: 10 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, #emailは空白にできない、文字数は255文字まで
            format: { with: VALID_EMAIL_REGEX }, #正規表現
            uniqueness: { case_sensitive: false } #同じemailは登録できない

  validates :image, presence: true, length: { maximum: 255 }

  has_secure_password #パスワードのハッシュ化
  validates :password, presence: true, length: { minimum: 6 } #空白スペースなどは設定不可、最低文字数は6文字
end
