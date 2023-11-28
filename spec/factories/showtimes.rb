FactoryBot.define do
  factory :showtime do
    start_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 15.days) }
    fare { Faker::Number.between(from: 80_000, to: 90_000) }
    room
    movie

    after(:build) do |showtime|
      showtime.cinema_id = showtime.room.cinema.id
      showtime.location_id = showtime.room.cinema.location.id
      showtime.duration = showtime.movie.length
      showtime.end_time = showtime.start_time + showtime.duration.minutes
    end
  end
end
