class ProductsController < BaseController
  # before_action :logged_in?
  def index
    if current_user
      @products = current_user.products
    else
      @products = Product.all
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_url
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_url
    else
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to products_url
  end

  def confirm
    Product.find(params[:id]).confirm
    redirect_to products_url
  end

  def deny
    Product.find(params[:id]).deny
    redirect_to products_url
  end

  def disable
    Product.find(params[:id]).disable
    redirect_to products_url
  end

  private
    def product_params
      params.require(:product).permit(:name, :prize, :image, :desc, :url, :status, :ratio,
                              :bonus, :recommend, :user_id)
    end
end
