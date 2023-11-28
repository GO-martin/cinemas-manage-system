module Customer::RoomsHelper
  def get_structure(row_index, column_index)
    @structures.where(row_index:, column_index:).first
  end

  def get_sold_ticket(row_index, column_index)
    @sold_tickets.where(seat_row: row_index, seat_column: column_index)
  end

  def get_selecting_seat(row_index, column_index)
    @selecting_seats.where(row_index:, column_index:)
  end
end
