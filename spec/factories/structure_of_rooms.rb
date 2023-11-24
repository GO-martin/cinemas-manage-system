FactoryBot.define do
  factory :structure_of_room do
    row_index { Faker::Number.between(from: 0, to: 8) }
    column_index { Faker::Number.between(from: 0, to: 8) }
    type_seat { 'ACTIVE' }
    after(:build) do |structure_of_room|
      room = create(:room)
      structure_of_room.room_id = room.id
    end
  end
end
