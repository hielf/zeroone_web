class Api::ProductsController < Api::BaseController
  # skip_before_action :authenticate_user!, only: [:index, :send_code]
  def index
    if current_user.user_type == "normal"
      @products = Product.where(status: "已审核", user_id: nil)
    else
      superior = current_user.superior
      @products = superior.products.where(status: "已审核") if superior
    end
    @current_user = current_user
  end

  def show
    @product = Product.find(params[:id])
    @current_user = current_user
  end

  def recommend_list
    @products = Product.where(status: "已审核", recommend: true)
    @current_user = current_user
  end
end
