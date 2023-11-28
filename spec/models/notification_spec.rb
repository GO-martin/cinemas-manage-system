require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'associations' do
    it { should belong_to(:notifiable) }
    it { should belong_to(:user) }
  end

  describe 'enums' do
    it { should define_enum_for(:user_role) }
    it { should define_enum_for(:schedule) }
  end
end
