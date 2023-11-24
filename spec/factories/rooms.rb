FactoryBot.define do
  factory :room do
<<<<<<< HEAD
    
=======
    name { Faker::Number.between(from: 1, to: 10).to_s }
    row_size { Faker::Number.between(from: 1, to: 9) }
    column_size { Faker::Number.between(from: 1, to: 9) }
    number_of_seats { row_size * column_size }

    after(:build) do |room|
      cinema = create(:cinema)
      room.cinema_id = cinema.id
    end
>>>>>>> 15396e5 (Update factories)
  end
end
