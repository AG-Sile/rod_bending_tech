class RemoveNameFromProductVariants < ActiveRecord::Migration[5.0]
  def change
    remove_column :product_variants, :name, :string
  end
end
