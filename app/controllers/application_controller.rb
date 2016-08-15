class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  before_action :logged_in

  private
    def logged_in
      unless (admin_logged_in? || user_logged_in?)
        flash[:danger] = t(:please_log_in)
        redirect_to user_login_path
      end
    end
end
