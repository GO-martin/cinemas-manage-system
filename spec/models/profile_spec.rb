require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:fullname) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'attached' do
    it { should have_one_attached(:avatar) }
  end
end
