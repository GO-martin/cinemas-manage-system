class ChangeEnumTypeMovie < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :status
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
