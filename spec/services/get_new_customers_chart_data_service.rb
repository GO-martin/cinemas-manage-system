require 'rails_helper'

RSpec.describe GetNewCustomersChartDataService, type: :model do
  describe '#call' do
    it 'get new customers chart data service' do
      create(:profile)

      period = 30
      data = GetNewCustomersChartDataService.call(period)

      expect(data).to have_key(:current_data)
      expect(data).to have_key(:total_new_users)
      expect(data[:total_new_users]).to eq(1)
    end
  end
end
