class Product < ApplicationRecord
  has_many :product_variants, inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :product_variants, allow_destroy: true
end
