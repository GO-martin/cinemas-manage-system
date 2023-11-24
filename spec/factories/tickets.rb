def seat_number_format(row_index, column_index)
  letters = ('A'..'Z').to_a
  letter = letters[row_index]
  "#{letter}#{column_index}"
end
FactoryBot.define do
  factory :ticket do
    after(:build) do |ticket|
      showtime = create(:showtime)
      supply = create(:supply, cinema_id: showtime.room.cinema.id)
      ticket.seat_row = Faker::Number.between(from: 1, to: showtime.room.row_size)
      ticket.seat_column = Faker::Number.between(from: 1, to: showtime.room.column_size)
      ticket.user_id = User.pluck(:id).sample
      ticket.showtime_id = showtime.id
      payment_intent = Stripe::PaymentIntent.create(amount: showtime.fare + supply.price,
                                                    currency: 'vnd',
                                                    description: 'Order for RetroCinema',
                                                    payment_method_types: [
                                                      'card'
                                                    ])
      ticket.price = payment_intent.amount
      ticket.stripe_payment_id = payment_intent.id
      ticket.seat_name = seat_number_format(ticket.seat_row, ticket.seat_column)
    end
  end
end
