require 'rails_helper'

RSpec.describe Movie, type: :model do
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
  describe 'get_top_movies' do
    it 'returns top movies' do
      user = create(:user)
      create(:profile, user:)
      ticket1 = create(:ticket, user:)

      period = 7
      number = 1
      expected_result = [{ id: ticket1.showtime.movie.id }]
      got_result = Movie.get_top_movies(number, period).map(&:attributes).map { |item| { id: item['id'] } }

      expect(got_result).to eq(expected_result)
    end
  end
end
