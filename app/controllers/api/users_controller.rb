class Api::UsersController < Api::BaseController
  skip_before_action :authenticate_user!, only: [:create, :send_code]
  def create
    return render json: {message: "参数错误"} if params[:user].blank?

    return render json: {message: "用户已存在"} if params[:user][:cell] && User.find_by(cell: params[:user][:cell])
    cell_code = CellCode.find_by(cell: params[:user][:cell], code: params[:user][:code])
    return render json: {message: "验证码错误"} if cell_code.nil?

    user = User.new(user_params)
    @superior = User.find_by(cell: params[:user][:invite_cell])
    user.superior = @superior if @superior
    if user.save
      render json: {cell: user.cell, token: user.token}, status: 201
    else
      return api_error(status: 422)
    end
  end

  def modify
    # return render json: {message: "参数错误"} if params[:user].blank?
    Rails.logger.warn "#{current_user.cell} update #{params}"
    # current_user.update(user_info_params)
    current_user.name = params["user"]["name"] if params["user"]["name"]
    current_user.id_card = params["user"]["id_card"] if params["user"]["id_card"]
    current_user.bank_card = params["user"]["bank_card"].to_s if params["user"]["bank_card"]
    current_user.bank = params["user"]["bank"].to_s if params["user"]["bank"]
    # Rails.logger.warn "#{current_user.cell} updated #{params["user"]["bank"]}"
    if current_user.save!
      # Rails.logger.warn "#{current_user.cell} updated ok"
      render json: {cell: current_user.cell, token: current_user.token}, status: 201
    else
      return api_error(status: 422)
    end
  end

  def verify_bank
    if (current_user.bank? && current_user.bank_card?)
      render json: {verified: "true", bank: current_user.bank, bank_card: current_user.bank_card}, status: 201
    else
      render json: {verified: "false"}, status: 201
    end
  end

  def send_code
    # create a random code, not unique
    code = rand(1000..9999)
    cell = params[:cell]

    # if succeed to send code, save the cell and code in table of cell_codes
    if User.send_code(cell, code)
      CellCode.where(cell: cell).delete_all
      CellCode.create(cell: cell, code: code)
      render json: {}, status: 200
    else
      return api_error(status: 422)
    end
  end

  def reset_password
    if current_user.authenticate(params[:old_password])
      if current_user.update(password: params[:password])
        current_user.reset_token
        return render json: {token: current_user.token, cell: current_user.cell}, status: 200
      end
    end
    return api_error(status: 422)
  end

  def center
    @user = current_user
  end

  private
    def user_params
      params.require(:user).permit(:cell, :password, :openid, :number, :name, :id_card, :bank_card, :bank)
    end

    def user_info_params
      params.require(:user).permit(:name, :id_card, :bank_card, :bank)
    end
end
