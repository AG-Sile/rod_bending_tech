class AddWeightHeightWidthLengthToProductVariants < ActiveRecord::Migration[5.0]
  def change
    add_column :product_variants, :weight_pounds, :integer
    add_column :product_variants, :weight_ounces, :integer
    add_column :product_variants, :height, :float
    add_column :product_variants, :width, :float
    add_column :product_variants, :length, :float
  end
end
