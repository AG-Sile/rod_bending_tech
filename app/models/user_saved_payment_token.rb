class UserSavedPaymentToken < ApplicationRecord
  belongs_to :user, foreign_key: :user_uuid, primary_key: :uuid, optional: true

end
