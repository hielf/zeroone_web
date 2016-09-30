class Api::ProductsController < Api::BaseController
  skip_before_action :authenticate_user!, only: [:index, :send_code]
  def index
    @products = Product.where(status: "已审核")
  end

  def show
    @product = Product.find(params[:id])
  end

  def recommend_list
    @products = Product.where(status: "已审核", recommend: true)
  end
end
