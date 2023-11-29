require 'rails_helper'

RSpec.describe GetLocationChartDataService, type: :model do
  describe '#call' do
    it 'get location chart data service' do
      profile = create(:profile)
      ticket = create(:ticket, user: profile.user)

      period = 7
      data = GetLocationChartDataService.call(period)

      got_total_price = data[:current_location_chart_data].map(&:attributes).slice(0)['total_price']
      expect(data).to have_key(:current_location_chart_data)
      expect(got_total_price).to eq(ticket.price)
    end
  end
end
