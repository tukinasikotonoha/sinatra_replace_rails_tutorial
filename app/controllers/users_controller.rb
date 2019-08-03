class UsersController < ApplicationController

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
      # 保存の成功をここで扱う。
      flash[:success] = "アカウントを作成しました"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  private

    def user_params
      params.require(:user).permit(:nickname, :email, :password,
                                   :password_confirmation, :image)
    end

end
