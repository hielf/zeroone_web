class UsersessionsController < ApplicationController
  skip_before_action :logged_in_user
  def new
    @user = User.new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      user_log_in user
      redirect_to user_root_url
    else
      flash.now[:danger] = t(:invalid_email_or_password)
      render 'new'
    end
  end

  def destroy
    user_logout if user_logged_in?
    redirect_to user_root_url
  end
end
