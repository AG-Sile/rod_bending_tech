class OrderItemsController < ApplicationController

  def create_shipping_transaction
    item = OrderItem.find item_params[:id]
    item.create_transaction
    redirect_to 'orders'
  end

  private

    def item_params
      params.permit(:id)
    end
end
