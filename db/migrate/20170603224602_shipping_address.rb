class ShippingAddress < ActiveRecord::Migration[5.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address_1
      t.string :street_address_2
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :country, default: 'US'
      t.references :order
      t.boolean :remember

      t.timestamps
    end
  end
end
