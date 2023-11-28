require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:users) { create_list(:user, 3) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'associations' do
    it { should have_many(:notifications) }
    it { should have_many(:tickets) }
    it { should have_one(:profile) }
  end

  describe 'scopes' do
    it 'return ordered' do
      expect(User.ordered.to_a).to eq users.sort_by(&:id).reverse
    end
  end
end
