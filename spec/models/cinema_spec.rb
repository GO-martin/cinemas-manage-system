require 'rails_helper'

RSpec.describe Cinema, type: :model do
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
end
