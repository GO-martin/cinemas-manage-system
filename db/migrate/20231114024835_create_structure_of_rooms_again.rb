class CreateStructureOfRoomsAgain < ActiveRecord::Migration[7.0]
  def change
    create_table :structure_of_rooms do |t|
      t.integer :row_index, null: false
      t.integer :column_index, null: false
      t.string :type_seat, null: false
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
