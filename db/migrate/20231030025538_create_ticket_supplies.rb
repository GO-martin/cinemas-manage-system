class CreateTicketSupplies < ActiveRecord::Migration[7.0]
  def change
    create_table :ticket_supplies do |t|
      t.references :ticket, null: false, foreign_key: true
      t.references :supply, null: false, foreign_key: true

      t.timestamps
    end
  end
end
