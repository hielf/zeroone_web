class Api::SessionsController < Api::BaseController
  skip_before_action :authenticate_user!
  def create
    @user = User.find_by(cell: params[:cell])
    if @user && (@user.authenticate(params[:password]) || CellCode.find_by(cell: @user.cell, code: params[:code]))
      @user.update(openid: params[:openid]) if params[:openid]
      render json: {token: @user.token, cell: @user.cell}
    elsif CellCode.find_by(cell: params[:cell], code: params[:code])
      @user = User.find_by(openid: params[:openid])
      if @user
        @user.cell = params[:cell]
        @user.save && (@user.authenticate(params[:password]) || CellCode.find_by(cell: @user.cell, code: params[:code]))
      else
        @user = User.create(cell: params[:cell], code: params[:code], openid: params[:openid], password: rand(1000..9999).to_s)
      end
      render json: {token: @user.token, cell: @user.cell}
    else
      return api_error(status: 401)
    end
  end
end
