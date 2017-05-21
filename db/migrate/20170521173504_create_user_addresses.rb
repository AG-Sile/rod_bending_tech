class CreateUserAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address_1
      t.string :street_address_2
      t.string :city
      t.string :state
      t.integer :zip_code
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
