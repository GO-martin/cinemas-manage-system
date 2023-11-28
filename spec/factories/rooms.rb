FactoryBot.define do
  factory :room do
    name { Faker::Number.between(from: 1, to: 10).to_s }
    row_size { Faker::Number.between(from: 1, to: 9) }
    column_size { Faker::Number.between(from: 1, to: 9) }
    number_of_seats { row_size * column_size }
    cinema
  end
end
