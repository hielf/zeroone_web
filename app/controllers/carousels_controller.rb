class CarouselsController < ApplicationController
  before_action :logged_in?
  def index
    @carousels = Carousel.all
  end

  def edit
    @carousel = Carousel.find(params[:id])
  end

  def update
    @carousel = Carousel.find(params[:id])
    if @carousel.update(carousel_params)
      redirect_to carousels_url
    else
      render 'edit'
    end
  end

  private
    def carousel_params
      params.require(:carousel).permit(:first, :second, :third)
    end
end
