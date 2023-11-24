require 'rails_helper'

RSpec.describe SetShowtimeParamsService, type: :model do
  let(:movie) { create(:movie) }
  let(:room) { create(:room) }
  describe '#call' do
    it 'set showtime params' do
      params = { room_id: room.id, movie_id: movie.id, start_time: Faker::Time.between(from: DateTime.now, to: DateTime.now + 15.days), fare: 80000 }
      data = SetShowtimeParamsService.call(params)
      expect(data).to have_key(:duration)
      expect(data).to have_key(:end_time)
      expect(data).to have_key(:cinema_id)
      expect(data).to have_key(:location_id)
    end
  end
end
