class ChangesOnProductVariants < ActiveRecord::Migration[5.0]
  def change
    drop_table :variant_attributes
    add_column :product_variants, :option, :string
  end
end
