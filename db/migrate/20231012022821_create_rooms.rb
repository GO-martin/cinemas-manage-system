class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :number_of_seats
      t.references :cinema, null: false, foreign_key: true
      t.integer :structure, array: true

      t.timestamps
    end
  end
end
