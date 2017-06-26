class AddShippingIdToOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :shipping_id, :string
    add_column :order_items, :shipping_rate_id, :string
    add_column :order_items, :shipping_transaction_id, :string
  end
end
