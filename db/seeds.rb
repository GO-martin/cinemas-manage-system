def seat_number_format(row_index, column_index)
  letters = ApplicationHelper::LETTERS
  letter = letters[row_index]
  "#{letter}#{column_index}"
end

# Admin
admin = User.create!(email: 'martin.nguyen.goldenowl@gmail.com', password: 'password')
admin.delete_roles
admin.add_role :admin
admin_profile = Profile.new(fullname: Faker::Lorem.sentence,
                            birthday: Faker::Date.birthday(min_age: 18, max_age: 65), address: Faker::Address.full_address, user_id: admin.id)
admin_profile.avatar.attach(io: File.open(Rails.root.join(*%w[app assets images HoneySweet.jpg])),
                            filename: 'HoneySweet.jpg')
admin_profile.save!

10.times do
  customer = User.create!(
    email: Faker::Internet.unique.email,
    password: 'password'
  )
  customer.add_role :customer
  customer_profile = Profile.new(
    fullname: Faker::Name.name,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
    address: Faker::Address.full_address,
    user_id: customer.id
  )
  customer_profile.avatar.attach(io: File.open(Rails.root.join(*%w[app assets images HoneySweet.jpg])),
                                 filename: 'HoneySweet.jpg')
  customer_profile.save!

  Location.create!(
    name: Faker::Address.city
  )
  Cinema.create!(
    name: Faker::Company.name,
    description: Faker::Lorem.paragraph,
    location_id: Location.pluck(:id).sample
  )
  movie = Movie.new(
    name: Faker::Movie.title,
    director: Faker::Name.name,
    description: Faker::Lorem.paragraph,
    release_date: Faker::Date.between(from: 5.years.ago, to: Date.today),
    length: Faker::Number.between(from: 60, to: 180),
    trailer: 'https://youtu.be/d-ck5QxqgMg?si=Tgj-TvmvW5IHQm8F',
    status: rand(2)
  )
  movie.poster.attach(io: File.open(Rails.root.join(*%w[app assets images HoneySweet.jpg])), filename: 'HoneySweet.jpg')
  movie.save!
  room = Room.create!(
    name: Faker::Number.between(from: 1, to: 10).to_s, 
    number_of_seats: Faker::Number.between(from: 1, to: 81),
    cinema_id: Cinema.pluck(:id).sample, 
    row_size: Faker::Number.between(from: 1, to: 9),
    column_size: Faker::Number.between(from: 1, to: 9)
  )
  
  row_size = room.row_size
  column_size = room.column_size
  room.update(number_of_seats: row_size * column_size)

  row_size.times do |r|
    column_size.times do |c|
      StructureOfRoom.create!(
        row_index: r,
        column_index: c,
        type_seat: 'ACTIVE',
        room_id: room.id
      )
    end
  end

  room_sample = Room.pluck(:id).sample

  showtime = Showtime.create!(
    room_id: room_sample, 
    movie_id: Movie.pluck(:id).sample, 
    start_time: Faker::Time.between(from: DateTime.now, to: DateTime.now + 15.days), 
    fare: Faker::Number.between(from: 80_000, to: 90_000), 
    duration: Faker::Number.between(from: 60, to: 90),
    location_id: Room.find_by(id: room_sample).cinema.id, 
    cinema_id: Room.find_by(id: room_sample).cinema.location.id 
  )
  showtime.update(end_time: showtime.start_time + showtime.duration.minutes)

  supply = Supply.new(
    quantity: Faker::Number.between(from: 50, to: 100),
    price: Faker::Number.between(from: 100_000, to: 500_000),
    name: Faker::Commerce.unique.product_name,
    cinema_id: Cinema.pluck(:id).sample, 
    description: Faker::Lorem.paragraph
  )

  supply.image.attach(io: File.open(Rails.root.join(*%w[app assets images PEANUTS_SINGLE.png])),
                      filename: 'PEANUTS_SINGLE.png')
  supply.save!

  payment_intent = Stripe::PaymentIntent.create(
    amount: showtime.fare + supply.price,
    currency: 'vnd',
    description: 'Order for RetroCinema',
    payment_method_types: [
      'card'
    ]
  )

  ticket = Ticket.create!(
    seat_row: Faker::Number.between(from: 1, to: room.row_size),
    seat_column: Faker::Number.between(from: 1, to: room.column_size),
    price: payment_intent.amount,
    user_id: customer.id,
    showtime_id: showtime.id,
    stripe_payment_id: payment_intent.id
  )

  ticket.update(seat_name: seat_number_format(ticket.seat_row, ticket.seat_column))

  TicketSupply.create!(
    ticket_id: ticket.id,
    supply_id: supply.id,
    quantity: 1
  )

  supply.update(quantity: supply.quantity - 1)
end
