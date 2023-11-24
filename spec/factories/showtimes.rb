FactoryBot.define do
  factory :showtime do
    start_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 15.days) }
    fare { Faker::Number.between(from: 80_000, to: 90_000) }

    after(:build) do |showtime|
      room = create(:room)
      movie = create(:movie)
      showtime.room_id = room.id
      showtime.movie_id = movie.id
      showtime.cinema_id = room.cinema.id
      showtime.location_id = room.cinema.location.id
      showtime.duration = movie.length
      showtime.end_time = showtime.start_time + showtime.duration.minutes
    end
  end
end
