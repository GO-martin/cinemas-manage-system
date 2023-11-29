require 'rails_helper'

RSpec.describe GetMainChartDataService, type: :model do
  describe '#call' do
    it 'get main chart data service' do
      profile = create(:profile)
      ticket = create(:ticket, user: profile.user)

      period = 7
      data = GetMainChartDataService.call(period)
      expect(data).to have_key(:current_main_chart_data)
      expect(data).to have_key(:total_revenue)
      expect(data[:total_revenue]).to eq(ticket.price)
    end
  end
end
