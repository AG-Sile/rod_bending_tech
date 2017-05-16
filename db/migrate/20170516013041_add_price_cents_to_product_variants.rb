class AddPriceCentsToProductVariants < ActiveRecord::Migration[5.0]
  def change
    add_column :product_variants, :price_cents, :integer
  end
end
