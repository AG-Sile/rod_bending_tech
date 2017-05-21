class ProductVariantsController < ApplicationController

  def show
    @product_variant = ProductVariant.find(params[:id])
    @cart_item = session_cart.cart_items.new
  end

  private

    def product_variant_params
      params.require(:product_variant)
    end

end
