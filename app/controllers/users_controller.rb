class UsersController < ApplicationController
  skip_before_action :login_required, except: :index
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to questions_path, success: 'サインアップが完了しました'
    else
      redirect_to new_user_path, error: 'ユーザー登録に失敗しました'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation)
  end

end
