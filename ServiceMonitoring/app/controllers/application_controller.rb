class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Check whether current user is admin or not
  def user_is_admin?
    user_signed_in? ? current_user.is_admin : false
  end
end
