require 'rails_helper'

RSpec.describe Supply, type: :model do
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
end
