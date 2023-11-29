require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'association' do
    it { should belong_to(:showtime) }
    it { should belong_to(:user) }
  end
end
