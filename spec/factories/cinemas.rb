FactoryBot.define do
  factory :cinema do
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    after(:build) do |cinema|
      location = create(:location)
      cinema.location_id = location.id
    end
  end
end
