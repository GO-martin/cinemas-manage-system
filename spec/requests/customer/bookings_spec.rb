require 'rails_helper'

RSpec.describe 'Customer::Bookings', type: :request do
  let!(:showtime) { create(:showtime) }
  let!(:room) { create(:room) }
  let!(:user) { create(:user) }
  let!(:valid_attributes) { attributes_for(:booking, showtime_id: showtime.id, row_index: 0, column_index: 0) }
  let!(:invalid_attributes) { attributes_for(:booking, showtime_id: showtime.id, row_index: 0, column_index: 0, user_id: nil) }
  let!(:booking) { create(:booking) }

  context 'not logged in' do
    describe 'POST #create' do
      it 'redirect sign in' do
        post customer_bookings_path, params: { booking: valid_attributes, user: }
        expect(response).to have_http_status(302)
      end
    end
  end

  context 'logged in' do
    before do
      @user = create(:user)
      @user.add_role :customer
      @profile = create(:profile, user: @user)
      sign_in @user
    end

    describe 'POST #create' do
      context 'with valid parameters' do
        it 'creates a new booking' do
          valid_attributes[:user_id] = @user.id
          expect do
            post customer_bookings_path, params: { booking: valid_attributes }
          end.to change(Booking, :count).by(1)
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          post customer_bookings_path, params: { booking: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested booking' do
        expect do
          delete customer_booking_path(booking)
        end.to change(Booking, :count).by(-1)
      end
    end
  end
end
