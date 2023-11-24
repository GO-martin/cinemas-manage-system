FactoryBot.define do
  factory :cinema do
<<<<<<< HEAD
    
=======
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    after(:build) do |cinema|
      location = create(:location)
      cinema.location_id = location.id
    end
>>>>>>> 15396e5 (Update factories)
  end
end
