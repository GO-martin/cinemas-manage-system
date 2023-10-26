class AddCinemaRefToShowtimes < ActiveRecord::Migration[7.0]
  def change
    add_reference :showtimes, :cinema, foreign_key: true
  end
end
