class ChangeEnumMovie < ActiveRecord::Migration[7.0]
  def change
    change_column :movies, :status, :string, default: 0
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
