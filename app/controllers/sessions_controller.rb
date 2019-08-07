class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user #app/helpers/sessions_helper.rb のメソッドを呼び出す

      #app/helpers/sessions_helper.rb のメソッドを呼び出す
      if params[:session][:remember_me] == '1'
        remember(user) #app/helpers/sessions_helper.rb のメソッドを呼び出す
      else
        forget(user) #app/helpers/sessions_helper.rb のメソッドを呼び出す
      end
      #上記のif文は下記のように三項演算子 で書くことも可能
      # params[:session][:remember_me] == '1' ? remember(user) : forget(user) #app/helpers/sessions_helper.rb のメソッドを呼び出す
      redirect_to user
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'email/passwordの入力に誤りがあります'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
