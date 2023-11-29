require 'rails_helper'

RSpec.describe GetNewTicketsChartDataService, type: :model do
  describe '#call' do
    it 'get new tickets chart data service' do
      profile = create(:profile)
      create(:ticket, user: profile.user)

      period = 30
      data = GetNewTicketsChartDataService.call(period)

      expect(data).to have_key(:current_data)
      expect(data).to have_key(:total_new_tickets)
      expect(data[:total_new_tickets]).to eq(1)
    end
  end
end
