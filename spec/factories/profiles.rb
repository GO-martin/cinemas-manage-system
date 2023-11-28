FactoryBot.define do
  factory :profile do
    fullname { Faker::Name.name }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    address { Faker::Address.full_address }
    user

    after(:build) do |profile|
      profile.avatar.attach(
        io: File.open(Rails.root.join(*%w[app assets images HoneySweet.jpg])),
        filename: 'HoneySweet.jpg'
      )
    end
  end
end
