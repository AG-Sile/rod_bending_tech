class Picture < ApplicationRecord
  belongs_to :product_variant
  validates :picture, presence: true
  mount_uploader :picture, PictureUploader
end
