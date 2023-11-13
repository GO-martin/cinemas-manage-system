class ChangeStatusToMovies < ActiveRecord::Migration[7.0]
  def change
    change_column :movies, :status, :string, default: 'now_showing'
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
