require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { subject.should validate_presence_of(:email) }
    it { subject.should validate_presence_of(:password) }
  end
end
