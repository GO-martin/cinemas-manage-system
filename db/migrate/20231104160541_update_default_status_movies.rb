class UpdateDefaultStatusMovies < ActiveRecord::Migration[7.0]
  def change
    change_column :movies, :status, :string, default: 'Now Showing'
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
