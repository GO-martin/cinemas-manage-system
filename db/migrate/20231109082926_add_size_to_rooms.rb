class AddSizeToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :row_size, :integer
    add_column :rooms, :column_size, :integer
  end
end
