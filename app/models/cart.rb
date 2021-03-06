class Cart < ApplicationRecord
  belongs_to :user, foreign_key: :user_uuid, primary_key: :uuid, optional: true
  has_many :cart_items, dependent: :destroy

  scope :shopping_cart, -> { where(cart_type: 'shopping_cart') }

  def self.previous_for_user(cart_id, user_uuid)
    Cart.shopping_cart.where(['id <> ? and user_uuid = ?', cart_id, user_uuid]).last
  end

  def merge_with_previous_cart!(user)
    if previous_cart = previous_cart(user)
      current_items = cart_items
      current_items.each do |item|
        previous_cart.add_item(product_variant_id: item.product_variant_id, quantity: item.quantity)
      end
      self.destroy!
      return previous_cart
    end
    self.user_uuid = user.uuid
    self.save!
    self
  end

  def add_item(params)
    already_exists = false
    self.cart_items.each do |item|
      if item.product_variant_id == params[:product_variant_id].to_i
        already_exists = true
        item.quantity += params[:quantity].to_i
        item.save!
      end
    end
    cart_items.create!(params) unless already_exists
  end

  def previous_cart(user)
    @previous_cart ||= Cart.previous_for_user(id, user.uuid)
  end

  def move_item_to(cart_type, item)
    user = item.cart.user
    new_cart = Cart.find_or_create_by(user: user, cart_type: cart_type)
    new_cart.add_item(product_variant_id: item.product_variant_id, quantity: item.quantity)
    item.destroy!
  end

  def subtotal
    subtotal = Money.zero
    cart_items.each do |item|
      subtotal += item.product_variant.price_cents * item.quantity
    end
    subtotal
  end

  def convert_to_order
    new_order = Order.find_or_create_by(user: user, status: 'pending_payment')
    new_order.order_items.map(&:destroy)
    cart_items.each do |item|
      new_order.add_item(item)
    end
    return new_order
  end

end
