class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :showtime, null: false, foreign_key: true
      t.integer :seat_id, null: false

      t.timestamps
    end
  end
end
