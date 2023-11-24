FactoryBot.define do
  factory :booking do
    after(:build) do |booking|
      showtime = create(:showtime)
      room = showtime.room
      booking.showtime_id = showtime.id
      booking.row_index = Faker::Number.between(from: 0, to: room.row_size - 1)
      booking.column_index = Faker::Number.between(from: 0, to: room.column_size - 1)
      booking.user_id = User.pluck(:id).sample
    end
  end
end
