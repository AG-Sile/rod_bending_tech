class CardToken < ApplicationRecord
  belongs_to :user, foreign_key: :user_uuid, primary_key: :uuid, optional: true
  belongs_to :order, optional: true

  scope :active, -> { where(status :active) }
end
