require 'rails_helper'

RSpec.describe 'Customer::Supplies', type: :request do
  let(:supply) { create(:supply) }
  context 'not logged in' do
    describe 'GET #index' do
      it 'redirect sign in' do
        get customer_supplies_path
        expect(response).to have_http_status(302)
      end
    end
  end

  context 'logged in' do
    before do
      @user = create(:user)
      @user.delete_roles
      @user.add_role :customer
      @profile = create(:profile, user: @user)
      sign_in @user
    end
    describe 'GET #booking_supplies' do
      it 'return a successful response' do
        supply
        get booking_supplies_customer_supplies_path, params: { cinema_id: supply.cinema.id }
        expect(response).to be_successful
      end
    end
  end
end
