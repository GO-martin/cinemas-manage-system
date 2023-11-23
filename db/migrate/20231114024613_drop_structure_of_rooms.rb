class DropStructureOfRooms < ActiveRecord::Migration[7.0]
  def change
    drop_table :structure_of_rooms
  end
end
