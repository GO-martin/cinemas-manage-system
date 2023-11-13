class RemoveStructureFromRooms < ActiveRecord::Migration[7.0]
  def change
    remove_column :rooms, :structure, :integer
  end
end
