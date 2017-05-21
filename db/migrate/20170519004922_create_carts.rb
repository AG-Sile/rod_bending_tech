class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true, index: true
      t.string :cart_type, index: true

      t.timestamps
    end
  end
end
