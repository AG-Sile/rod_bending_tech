class OrderController < ApplicationController

  def create
    @order = Order.new order_params.merge(email: stripe_params["stripeEmail"],
                                                               card_token: stripe_params["stripeToken"])
    raise "Please, check order errors" unless @order.valid?
    @order.card_token.create!(card_token: card_token)
    @order.process_payment(card_token)
    @order.save
    redirect_to @order, notice: 'Order was successfully created.'
  rescue e
    flash[:error] = e.message
    render :new
  end

  private


    def stripe_params
      params.permit :stripeEmail, :stripeToken
    end

end
