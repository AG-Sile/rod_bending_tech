class OrdersController < ApplicationController

  def new
    @order = current_user.pending_order
  end

  def create
  end

  def create_shipping_label(id:)
    item = OrderItem.find(id)
    item.create_transaction
  end

  def index
  end

  def show_items
    @order = current_user.pending_order
  end

  def update_items
    @order = current_user.pending_order
    @order.order_items.each do |item|
      if shipping_params = shipping_params(id: item.id)
        rate, shipment = shipping_params[:"#{item.id}_rate"].split(' ')
        item.shipping_id = shipment
        item.shipping_rate_id = rate
        item.save
      else
        flash[:error] = "Please select shipping options for all items"
        redirect_to check_out_2_path
        return
      end
    end
    @order.taxes_cents = (@order.calculate_tax * 100).to_i
    @order.total_price = (@order.calculate_final_price * 100).to_i
    @order.save!
    redirect_to check_out_3_path
  end

  def update
    @order = current_user.pending_order
    raise "Please, check order errors" unless @order.valid?
    @order.process_payment(stripe_params[:stripeToken])
    @order.status = 'pending_shipment'
    @order.save!
    current_user.carts.shopping_cart.first.destroy!
    redirect_to root_url, notice: 'Order was successfully created.'

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

   def shipping_params(id:)
      params.permit("#{id}_rate")
   end
end
