class AddLocationToShowtimes < ActiveRecord::Migration[7.0]
  def change
    add_reference :showtimes, :location, null: false, foreign_key: true, default: 2
    # Ex:- :default =>''
  end
end
