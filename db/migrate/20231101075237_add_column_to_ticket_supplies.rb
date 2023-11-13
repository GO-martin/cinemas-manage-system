class AddColumnToTicketSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :ticket_supplies, :quantity, :integer
  end
end
