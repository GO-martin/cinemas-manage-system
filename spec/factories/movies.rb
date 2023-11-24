FactoryBot.define do
  factory :movie do
<<<<<<< HEAD
    
=======
    name { Faker::Movie.title }
    director { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    release_date { Faker::Date.between(from: 5.years.ago, to: Date.today) }
    length { Faker::Number.between(from: 60, to: 180) }
    trailer { 'https://youtu.be/d-ck5QxqgMg?si=Tgj-TvmvW5IHQm8F' }

    after(:build) do |movie|
      movie.poster.attach(
        io: File.open(Rails.root.join(*%w[app assets images HoneySweet.jpg])),
        filename: 'HoneySweet.jpg'
      )
    end
>>>>>>> 15396e5 (Update factories)
  end
end
