module Customer::BaseHelper
  LETTER = %w[A B C D E F G H I]
  def convert_coordinates_to_seat(row_index, column_index)
    "#{LETTER.at(row_index)}#{column_index}"
  end
end
