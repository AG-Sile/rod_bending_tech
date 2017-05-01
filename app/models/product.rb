class Product < ApplicationRecord
  has_many :product_variants, inverse_of: :product, dependent: :destroy
  has_many :pictures, through: :product_variants
  accepts_nested_attributes_for :product_variants, allow_destroy: true
  accepts_nested_attributes_for :pictures, allow_destroy: true
end
