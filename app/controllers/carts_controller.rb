class CartsController < ApplicationController
  def show
    @cart_items = session_cart.cart_items
  end
end
