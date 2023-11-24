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
end
