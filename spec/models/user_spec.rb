require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
  describe 'associations' do
    it { should have_many(:notifications) }
    it { should have_many(:tickets) }
    it { should have_one(:profile) }
  end
end
