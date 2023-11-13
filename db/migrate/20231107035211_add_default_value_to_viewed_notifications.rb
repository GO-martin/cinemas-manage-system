class AddDefaultValueToViewedNotifications < ActiveRecord::Migration[7.0]
  def change
    change_column :notifications, :viewed, :boolean, default: false
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
