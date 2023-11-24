FactoryBot.define do
  factory :location do
    name { Faker::Lorem.unique.word }
  end
end
