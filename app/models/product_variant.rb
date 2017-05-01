class ProductVariant < ApplicationRecord
  belongs_to :product
  has_many :pictures, dependent: :destroy, inverse_of: :product_variant
  accepts_nested_attributes_for :pictures, :allow_destroy => true
end
