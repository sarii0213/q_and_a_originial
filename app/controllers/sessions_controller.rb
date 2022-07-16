class SessionsController < ApplicationController
  skip_before_action :login_required
  layout 'layouts/sessions'
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to questions_path, success: 'ログインしました'
    else
      redirect_to login_path, error: 'ログイン失敗しました'
    end
  end

  def destroy
    reset_session
    redirect_to login_path, success: 'ログアウトしました'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
