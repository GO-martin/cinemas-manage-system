require 'rails_helper'

RSpec.describe GetCollateralTabsDataService, type: :model do
  describe '#call' do
    it 'get new tickets chart data service' do
      showtime = create(:showtime)

      data = GetCollateralTabsDataService.call(Date.today, showtime.movie.id)

      expect(data).to be_an(Array)
    end
  end
end
