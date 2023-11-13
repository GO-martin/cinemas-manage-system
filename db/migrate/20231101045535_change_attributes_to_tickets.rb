class ChangeAttributesToTickets < ActiveRecord::Migration[7.0]
  def change
    rename_column :tickets, :seat_collumn, :seat_column
    remove_column :tickets, :supply_quantity
  end
end
