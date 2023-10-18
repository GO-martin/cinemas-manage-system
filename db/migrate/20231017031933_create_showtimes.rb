class CreateShowtimes < ActiveRecord::Migration[7.0]
  def change
    create_table :showtimes do |t|
      t.references :room, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.datetime :start_time
      t.float :fare

      t.timestamps
    end
  end
end
