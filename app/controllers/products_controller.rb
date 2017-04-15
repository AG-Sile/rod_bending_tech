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
    if @product.save
      flash[:info] = "Product succesfully created."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Product updated"
      redirect_to @product
    else
      render 'edit'
    end
  end

  private

    def product_params
      params.require(:product).permit(:name, :description)
    end

end
