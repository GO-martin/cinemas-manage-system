class StructureOfRoom < ApplicationRecord
  belongs_to :room

  validates :row_index, :column_index, :room_id, :type_seat, presence: true
  validates :row_index, uniqueness: { scope: %i[column_index room_id] }
end
