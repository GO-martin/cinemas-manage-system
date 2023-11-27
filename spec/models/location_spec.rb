require 'rails_helper'

RSpec.describe Location, type: :model do
  let!(:locations) { create_list(:location, 3) }

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
end
