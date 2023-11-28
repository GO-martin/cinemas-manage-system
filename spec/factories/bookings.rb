FactoryBot.define do
  factory :booking do
    showtime
    after(:build) do |booking|
      room = booking.showtime.room
      booking.row_index = Faker::Number.between(from: 0, to: room.row_size - 1)
      booking.column_index = Faker::Number.between(from: 0, to: room.column_size - 1)
      booking.user_id = User.pluck(:id).sample
    end
  end
end
