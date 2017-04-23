class CreateProductVariants < ActiveRecord::Migration[5.0]
  def change
    create_table :product_variants do |t|
      t.string :name
      t.string :variation
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
