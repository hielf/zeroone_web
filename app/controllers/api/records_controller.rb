class Api::RecordsController < Api::BaseController
  # skip_before_action :authenticate_user!, only: [:create, :send_code]
  def notify
    Rails.logger.warn "notify #{Time.now}, sign: #{params[:sign]};"
  end
end
