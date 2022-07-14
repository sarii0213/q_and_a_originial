class Admin::SessionsController < Admin::BaseController
  layout 'admin/layouts/sessions'
  skip_before_action :login_required
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user.present? && @user.authenticate(session_params[:password]) && @user.admin?
      session[:user_id] = @user.id
      redirect_to admin_questions_path, info: '管理画面にログインしました'
    else
      flash[:danger] = '管理画面にログインできませんでした'
      redirect_to admin_login_path
    end
  end

  def destroy
    reset_session
    redirect_to admin_login_path, notice: '管理者画面からログアウトしました'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :admin)
  end
end
