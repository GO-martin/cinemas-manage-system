require 'rails_helper'

RSpec.describe Supply, type: :model do
  let!(:supplies) { create_list(:supply, 3) }
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:cinema_id) }
  end

  describe 'associations' do
    it { should belong_to(:cinema) }
    it { should have_many(:ticket_supplies) }
    it { should have_many(:tickets) }
  end

  describe 'attached' do
    it { should have_one_attached(:image) }
  end
  describe 'scopes' do
    it 'return ordered' do
      expect(Supply.ordered.to_a).to eq supplies.sort_by(&:id).reverse
    end
  end
  describe 'quantity_more_than' do
    it 'returns supplies with quantity more than a specified value' do
      create(:supply, quantity: 50000)
      supply2 = create(:supply, quantity: 100000)
      create(:supply, quantity: 30000)

      expect(Supply.quantity_more_than(60000)).to contain_exactly(supply2)
    end
  end
end
