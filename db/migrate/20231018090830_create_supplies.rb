class CreateSupplies < ActiveRecord::Migration[7.0]
  def change
    create_table :supplies do |t|
      t.integer :quantity
      t.float :price
      t.string :name
      t.references :cinema, null: false, foreign_key: true

      t.timestamps
    end
  end
end
