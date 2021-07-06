class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.company_id = params[:company_id]
    if @product.save
      # byebug
      redirect_to company_product_path(params[:company_id], @product)
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
