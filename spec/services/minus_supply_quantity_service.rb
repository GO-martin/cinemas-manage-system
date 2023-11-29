require 'rails_helper'

RSpec.describe MinusSupplyQuantityService, type: :model do
  describe '#call' do
    it 'minus supply quantity service service' do
      supply = create(:supply, quantity: 1)

      params = { ticket_supply: { supply_id: supply.id, quantity: 1 } }

      MinusSupplyQuantityService.call(params)
      supply.reload
      expect(supply.quantity).to eq(0)
    end
  end
end
