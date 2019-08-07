class UsersController < ApplicationController
  #ログインしてないユーザーはプロフィール編集ページにはアクセス不可
  before_action :logged_in_user, only: [:edit, :update]

  #間違って、他の人のプロフィール編集ページにアクセスできないようにする
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザーを作成しました"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:nickname, :email, :password,
                                   :password_confirmation, :image)
    end

    # beforeアクション
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認 =>アクセスしようとしているユーザーのIDと、今ログインしているユーザーのIDを比較している
    def correct_user
      @user = User.find(params[:id])

      #sessions_helper.rb からcurrent_user?(user)メソッドを呼び出す
      redirect_to(root_url) unless current_user?(@user)
    end

end
