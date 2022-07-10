class ApplicationController < ActionController::Base
  add_flash_types :danger, :success
  helper_method :current_user

  private

  def current_user
    @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
