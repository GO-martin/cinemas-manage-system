class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.integer :seat_row, null: false
      t.integer :seat_collumn, null: false
      t.float :price, null: false
      t.references :user, null: false, foreign_key: true
      t.references :showtime, null: false, foreign_key: true
      t.references :supply, null: false, foreign_key: true
      t.integer :supply_quantity

      t.timestamps
    end
  end
end
