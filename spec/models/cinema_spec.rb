require 'rails_helper'

RSpec.describe Cinema, type: :model do
  let!(:cinemas) { create_list(:cinema, 3) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:location_id) }
  end
  describe 'associations' do
    it { should have_many(:rooms) }
    it { should have_many(:supplies) }
    it { should have_many(:showtimes) }
    it { should belong_to(:location) }
  end

  describe 'scopes' do
    it 'return ordered' do
      expect(Cinema.ordered.to_a).to eq cinemas.sort_by(&:id).reverse
    end
  end
end
