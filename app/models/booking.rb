class Booking < ApplicationRecord
  belongs_to :showtime
  belongs_to :user

  after_commit do
    other_users = User.other_users(user_id)
    other_users.each do |user|
      broadcast_replace_to "broadcast_to_user_#{user&.id}",
                           target: "seat_#{row_index}_#{column_index}_#{showtime_id}",
                           partial: 'customer/rooms/seat',
                           locals: {
                             selecting_seat: Booking.where(showtime_id:, row_index:, column_index:),
                             type_seat: 'ACTIVE',
                             row_index:,
                             column_index:,
                             showtime_id:,
                             sold_ticket: Ticket.where(showtime_id:, seat_row: row_index, seat_column: column_index)
                           }
    end
  end
end
