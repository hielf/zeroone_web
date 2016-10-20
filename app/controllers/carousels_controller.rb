class CarouselsController < ApplicationController
  before_action :logged_in?
  def index
    @carousels = Carousel.all
  end

  def destroy
    Carousel.find(params[:id]).destroy
    redirect_to carousels_url
  end

  def new
    @carousel = Carousel.new
  end

  def create
    @carousel = Carousel.new(carousel_params)
    if @carousel.save
      redirect_to carousels_url
    else
      render 'new'
    end
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
