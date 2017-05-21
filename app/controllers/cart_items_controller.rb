class CartItemsController < ApplicationController

  def create
    @cart = session_cart
    @cart_items = @cart.add_item(cart_item_params)
    @cart.save
    session[:cart_id] = @cart.id
    redirect_to cart_items_path
  end

  def destroy
    @item = CartItem.find(params[:id])
    if current_user
      session_cart.move_item_to('deleted_items', @item)
    else
      cart_item.destroy!
    end
    redirect_to :back
  end

  def update
    @item = CartItem.find(params[:id])
    if @item.update_attributes(cart_item_params)
      flash.notice = "Updated!"
    else
      flash.now[:failure] = "There was a problem updating your cart items"
    end
    redirect_to cart_items_path
  end
  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_variant_id, :id, :_destroy)
  end

end
