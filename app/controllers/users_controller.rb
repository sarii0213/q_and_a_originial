class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "ユーザー「#{@user.name}」を登録しました"
    else
      redirect_to new_user_path, danger: 'ユーザー登録に失敗しました'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation)
  end

end
