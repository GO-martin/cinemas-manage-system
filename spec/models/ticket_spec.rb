require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let!(:user) { create(:user) }
  let!(:profile) { create(:profile, user:) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:showtime) }
    it { should have_many(:ticket_supplies) }
    it { should have_many(:supplies) }
  end

  describe 'total_revenue' do
    it 'returns the total revenue for a given period' do
      ticket1 = create(:ticket, user:)
      ticket2 = create(:ticket, user:)

      period = 7
      expected_result = ticket1.price + ticket2.price
      expect(Ticket.total_revenue(period)).to eq(expected_result)
    end
  end

  describe 'main_chart_data' do
    it 'returns main chart data for a given period' do
      ticket = create(:ticket, user:)

      period = 7
      expected_date = ticket.created_at.to_date
      expected_result = { expected_date => ticket.price }
      expect(Ticket.main_chart_data(period)).to eq(expected_result)
    end
  end

  describe 'tickets_chart_data' do
    it 'returns tickets chart data for a given period' do
      ticket1 = create(:ticket, user:)
      create(:ticket, user:)

      period = 7.days
      expected_result = { ticket1.created_at.to_date => 2 }
      expect(Ticket.tickets_chart_data(period)).to eq(expected_result)
    end
  end
end
