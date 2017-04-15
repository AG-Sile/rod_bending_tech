class ProductVariant < ApplicationRecord
  belongs_to :product

  validates :product_id, presence: true
end
