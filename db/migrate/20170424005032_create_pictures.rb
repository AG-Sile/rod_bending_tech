class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.string :picture
      t.references :product_variant, foreign_key: true

      t.timestamps
    end
  end
end
