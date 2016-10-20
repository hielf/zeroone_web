class Api::CarouselsController < Api::BaseController
  # skip_before_action :authenticate_user!, only: [:index, :send_code]
  def index
    @carousels = Carousel.all
  end
end
