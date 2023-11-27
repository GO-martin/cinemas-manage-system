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
end
