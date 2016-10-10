class Api::RecordsController < Api::BaseController
  skip_before_action :authenticate_user!, only: [:notify]
  def notify
    Rails.logger.warn "notify #{Time.now}, sign: #{params[:sign]}, other #{params};"

    render json: {result: "ok"}, status: 201
  end
end
