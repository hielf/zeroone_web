class UsersController < ApplicationController
  skip_before_action :logged_in, only: [:new, :create]

  def index
    if current_user
      @users = current_user.subordinates
    else
      @users = User.all
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user_type = "channel"
    @user.superior = current_user if current_user
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_users_url
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
  end

  def export
    @users = User.all
    respond_to do |format|
      header_string = 'attachment; filename=users' + DateTime.now.to_s(:number) + ".xlsx"
      format.xlsx{  response.headers['Content-Disposition'] = header_string}
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :openid, :avatar, :name, :email,
        :cell, :number, :channel,
        :password, :password_confirmation, :type)
    end
end
