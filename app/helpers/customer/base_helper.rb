module Customer::BaseHelper
  def seat_number_format(row_index, column_index)
    letters = ('A'..'Z').to_a
    letter = letters[row_index]
    "#{letter}#{column_index}"
  end
end
