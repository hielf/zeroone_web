class Api::CodesController < Api::BaseController
  skip_before_action :authenticate_user!
  def index
    render json: {serial_number: Code.create.id}
  end
end