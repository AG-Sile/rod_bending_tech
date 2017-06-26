class Order < ApplicationRecord

  has_many :order_items, dependent: :destroy
  has_many :card_tokens, dependent: :destroy
  belongs_to :user, foreign_key: :user_uuid, primary_key: :uuid
  has_many :shipping_addresses
  accepts_nested_attributes_for :shipping_addresses

  ALLOWED_STATUSES = ['pending_payment', 'pending_shipment', 'shipped', 'cancelled']

  validates :status, :inclusion => { :in => ALLOWED_STATUSES }

  scope :pending_payment, ->  { where(status: 'pending_payment')  }
  scope :pending_shipment, -> { where(status: 'pending_shipment') }

  composed_of :taxes_cents,
              :class_name => 'Money',
              :mapping => %w(taxes_cents cents),
              :converter => Proc.new { |value| Money.new(value) }


  composed_of :total_price,
              :class_name => 'Money',
              :mapping => %w(total_price cents),
              :converter => Proc.new { |value| Money.new(value) }

  def save_card(card_token)
    customer = Stripe::Customer.create email: order.user.email,
                                       source: card_token
    user.user_saved_payment_token.create!(stripe_customer_id: customer.id)
  end

  def process_payment(card_token)
    Stripe::Charge.create(
      source: card_token,
      amount: (total_price * 100).to_i,
      description: id,
      currency: 'usd'
    )
  end

  def add_item(cart_item)
    order_items.create!(product_variant: cart_item.product_variant,
      quantity: cart_item.quantity,
      individual_price: cart_item.product_variant.price_cents
    )
  end

  def items_price
    sum = 0
    order_items.each do |item|
      sum += (item.individual_price * item.quantity)
    end
    sum
  end

  def shipping_costs
    sum = 0
    order_items.each do |item|
      sum += item.get_shipment_rate_object[:amount].to_money
    end
    sum
  end

  def calculate_tax
    if shipping_addresses.first.state == 'IL'
      ((items_price + shipping_costs) * 0.1025)
    else
      0
    end
  end

  def calculate_final_price
    items_price + calculate_tax + shipping_costs
  end
end
