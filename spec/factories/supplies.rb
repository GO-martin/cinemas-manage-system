FactoryBot.define do
  factory :supply do
<<<<<<< HEAD
    
=======
    quantity { Faker::Number.between(from: 500, to: 1000) }
    price { Faker::Number.between(from: 100_000, to: 500_000) }
    name { Faker::Commerce.unique.product_name }
    description { Faker::Lorem.paragraph }

    after(:build) do |supply|
      cinema = create(:cinema)
      supply.cinema_id = cinema.id
    end
>>>>>>> 15396e5 (Update factories)
  end
end
