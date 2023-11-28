class AddSeatIndexToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :row_index, :integer, null: false
    add_column :bookings, :column_index, :integer, null: false
    remove_column :bookings, :seat_id
  end
end
