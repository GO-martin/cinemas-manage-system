require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:showtime) }
    it { should have_many(:ticket_supplies) }
    it { should have_many(:supplies) }
  end
end
