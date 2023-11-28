class AddAttributesToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :user_role, :integer, default: 0
    add_column :notifications, :schedule, :integer, default: 0
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
