class UsersessionsController < ApplicationController
  skip_before_action :logged_in_user
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:usersession][:email])
    if user && user.authenticate(params[:usersession][:password])
      user_log_in user
      redirect_to products_url
    else
      flash.now[:danger] = t(:invalid_email_or_password)
      redirect_to root_url
    end
  end

  def destroy
    user_logout if user_logged_in?
    redirect_to root_url
  end
end
