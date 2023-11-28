module Customer::BaseHelper
  def seat_number_format(row_index, column_index)
    letters = ApplicationHelper::LETTERS
    letter = letters[row_index]
    "#{letter}#{column_index}"
  end
end
