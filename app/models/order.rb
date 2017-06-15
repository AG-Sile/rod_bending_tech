class Order < ApplicationRecord

  has_many :order_items, dependent: :destroy
  has_many :card_tokens, dependent: :destroy
  belongs_to :user, foreign_key: :user_uuid, primary_key: :uuid
  has_many :shipping_addresses
  accepts_nested_attributes_for :shipping_addresses

  ALLOWED_STATUSES = ['pending_payment', 'received', 'shipped', 'delivered', 'cancelled']

  validates :status, :inclusion => { :in => ALLOWED_STATUSES }

  scope :pending_payment, -> { where(status: 'pending_payment') }

  def save_card(card_token)
    customer = Stripe::Customer.create email: order.user.email,
                                       source: card_token
    user.user_saved_payment_token.create!(stripe_customer_id: customer.id)
  end

  def process_payment(card_token)
    if card_token
      Stripe::Charge.create(
        source: card_token,
        amount: 500,
        description: id,
        currency: 'usd'
      )
    else
      Stripe::Charge.create(
        customer: user.card_tokens.stripe_customer_id,
        amount: 500,
        description: id,
        currency: 'usd'
      )
    end
  end

  def add_item(cart_item)
    order_items.create!(product_variant: cart_item.product_variant,
      quantity: cart_item.quantity,
      individual_price: cart_item.product_variant.price_cents
    )
  end
end
