class ChangePriceToTickets < ActiveRecord::Migration[7.0]
  def change
    change_column :tickets, :price, :integer
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
