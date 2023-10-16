class CreateStructureOfRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :structure_of_rooms do |t|
      t.integer :row
      t.integer :column
      t.string :type
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
