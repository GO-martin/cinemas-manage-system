require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:cinemas) }
    it { should have_many(:showtimes) }
  end

  describe 'scopes' do
    it 'return ordered' do
      expect(Location.ordered.to_a).to eq locations.sort_by(&:id).reverse
    end
  end
  describe 'locations_chart_data' do
    it 'returns location chart data based on period' do
      user = create(:user)
      create(:profile, user:)
      ticket = create(:ticket, user:)

      period = 7
      expected_result = [{ id: ticket.showtime.location.id, name: ticket.showtime.location.name,
                           total_price: ticket.price }]
      got_result = Location.locations_chart_data(period).map(&:attributes).map do |item|
        { id: item['id'], name: item['name'], total_price: item['total_price'] }
      end

      expect(got_result).to eq(expected_result)
    end
  end
end
