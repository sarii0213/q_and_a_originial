class ApplicationController < ActionController::Base
  add_flash_types :danger, :success, :info
  helper_method :current_user
  before_action :login_required

  private

  def current_user
    @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_path, notice: 'ログインしてください' unless current_user
  end
end
