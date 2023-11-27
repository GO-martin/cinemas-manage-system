require 'rails_helper'

RSpec.describe Movie, type: :model do
  let!(:movies) { create_list(:movie, 3) }
  describe 'validations' do
    it { should validate_presence_of(:director) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:length) }
    it { should validate_presence_of(:release_date) }
    it { should validate_presence_of(:trailer) }
    it { should validate_presence_of(:trailer) }
    it { should validate_presence_of(:description) }
  end
  describe 'enums' do
    it { should define_enum_for(:status) }
  end
  describe 'associations' do
    it { should have_many(:showtimes) }
  end
  describe 'scopes' do
    it 'return ordered' do
      expect(Movie.ordered.to_a).to eq movies.sort_by(&:id).reverse
    end
  end
end
