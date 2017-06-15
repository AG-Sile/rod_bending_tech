class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :status
      t.integer :total_price
      t.uuid :user_uuid

      t.timestamps
    end
  end
end
