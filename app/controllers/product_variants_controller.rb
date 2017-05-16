class ProductVariantsController < ApplicationController

  def show
    @product_variant = ProductVariant.find(params[:id])
  end

  private

    def product_variant_params
      params.require(:product_variant)
    end

end
