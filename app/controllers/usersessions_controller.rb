class UsersessionsController < BaseController
  skip_before_action :logged_in

  def new
    @user = User.new
  end

  def create
    user = User.find_by(cell: params[:usersession][:cell])
    if user && user.authenticate(params[:usersession][:password])
      user_log_in user
      redirect_to records_url
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
