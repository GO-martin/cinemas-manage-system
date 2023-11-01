class AddAttributesToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :stripe_payment_id, :string
    remove_column :tickets, :supply_id
  end
end
