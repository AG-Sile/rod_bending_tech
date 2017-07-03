class AddTaxesCentsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :taxes_cents, :integer
  end
end
