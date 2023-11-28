FactoryBot.define do
  factory :cinema do
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    location
  end
end
