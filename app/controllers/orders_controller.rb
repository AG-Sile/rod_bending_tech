class OrdersController < ApplicationController

  def new
    @order = current_user.carts.shopping_cart.first.convert_to_order
    @order.shipping_addresses.new
  end

  def create
  end

  def show_items
    binding.pry
    @order = current_user.pending_order
  end

  def update_items
  end

  def update
    @order = current_user.pending_order
    binding.pry
    raise "i don't want to continue now"
    raise "Please, check order errors" unless @order.valid?
    @order.card_tokens.create!(card_token: stripe_params[:stripeToken])
    @order.process_payment(stripe_params[:stripeToken])
    @order.save
    redirect_to @order, notice: 'Order was successfully created.'

    rescue Stripe::CardError => e
      flash[:error] = e.message
      render :new
  end

  private

    def address_params
      params.permit(:address)
    end

    def stripe_params
      params.permit :stripeEmail, :stripeToken
    end

    def new_address_params
      params.require(:order).permit(
        shipping_address: [:first_name,
          :last_name,
          :street_address_1,
          :street_address_2,
          :city,
          :zip_code,
          :state,
          :remember,
          :_destroy,]
      )
    end
end
