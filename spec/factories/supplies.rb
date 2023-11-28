FactoryBot.define do
  factory :supply do
    quantity { Faker::Number.between(from: 500, to: 1000) }
    price { Faker::Number.between(from: 100_000, to: 500_000) }
    name { Faker::Commerce.unique.product_name }
    description { Faker::Lorem.paragraph }
    cinema
  end
end
