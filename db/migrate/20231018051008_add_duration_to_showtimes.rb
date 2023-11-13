class AddDurationToShowtimes < ActiveRecord::Migration[7.0]
  def change
    add_column :showtimes, :duration, :integer
    add_column :showtimes, :end_time, :datetime
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
