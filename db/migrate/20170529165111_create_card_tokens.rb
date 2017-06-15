class CreateCardTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :card_tokens do |t|
      t.uuid :user_uuid
      t.integer :stripe_customer_id
      t.string :card_token
      t.integer :order_id
      t.boolean :active, default: true
    end
  end
end
