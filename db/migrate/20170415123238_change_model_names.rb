class ChangeModelNames < ActiveRecord::Migration[5.0]
  def change
    rename_table :variants, :product_variants
    rename_table :attributes, :variant_attributes
  end
end
