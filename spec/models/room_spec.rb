require 'rails_helper'

RSpec.describe Room, type: :model do
  let!(:rooms) { create_list(:room, 3) }
  let!(:cinema) { create(:cinema) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cinema_id) }
    it { should validate_presence_of(:row_size) }
    it { should validate_presence_of(:column_size) }
  end

  describe 'associations' do
    it { should have_many(:structure_of_rooms) }
    it { should have_many(:showtimes) }
    it { should belong_to(:cinema) }
  end

  describe 'scopes' do
    it 'return ordered' do
      expect(Room.ordered.to_a).to eq rooms.sort_by(&:id).reverse
    end
  end

  describe 'defaults' do
    it 'sets default values when a new record is initialized' do
      room = Room.new
      expect(room.number_of_seats).to eq(Structure::NUMBER_OF_SEATS)
      expect(room.row_size).to eq(Structure::ROW_SIZE)
      expect(room.column_size).to eq(Structure::COLUMN_SIZE)
    end
  end

  describe 'class methods' do
    describe 'by_filter' do
      it 'returns rooms filtered by search term and cinema' do
        room1 = create(:room, name: 'Room 1')
        create(:room, name: 'Room 2')

        expect(Room.by_filter('Room 1', room1.cinema.id)).to contain_exactly(room1)
      end
    end
  end
end
