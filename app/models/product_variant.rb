class ProductVariant < ApplicationRecord
  belongs_to :product
  has_many :pictures, dependent: :destroy, inverse_of: :product_variant
  has_many :cart_items

  accepts_nested_attributes_for :pictures, :allow_destroy => true

  composed_of :price_cents,
              :class_name => 'Money',
              :mapping => %w(price_cents cents),
              :converter => Proc.new { |value| value.to_money }
end
