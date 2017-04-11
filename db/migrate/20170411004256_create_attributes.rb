class CreateAttributes < ActiveRecord::Migration[5.0]
  def change
    create_table :attributes do |t|
      t.string :name
      t.references :variant, foreign_key: true

      t.timestamps
    end
  end
end
