require 'rails_helper'

RSpec.describe Showtime, type: :model do
  let!(:showtimes) { create_list(:showtime, 3) }
  describe 'validations' do
    it { should validate_presence_of(:room_id) }
    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:fare) }
  end
  describe 'associations' do
    it { should have_many(:tickets) }
    it { should belong_to(:cinema) }
    it { should belong_to(:room) }
    it { should belong_to(:movie) }
    it { should belong_to(:location) }
  end
  describe 'scopes' do
    it 'return ordered' do
      expect(Showtime.ordered.to_a).to eq showtimes.sort_by(&:id).reverse
    end
  end
end
