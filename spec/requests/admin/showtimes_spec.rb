require 'rails_helper'

RSpec.describe 'Admin::Showtimes', type: :request do
  let!(:room) { create(:room) }
  let!(:movie) { create(:movie) }
  let!(:valid_attributes) { attributes_for(:showtime, room_id: room.id, movie_id: movie.id) }
  let!(:invalid_attributes) { attributes_for(:showtime, fare: nil, room_id: room.id, movie_id: movie.id) }
  let!(:showtime) { create(:showtime) }

  context 'not logged in' do
    describe 'GET index' do
      it 'redirect sign in' do
        get admin_showtimes_path
        expect(response).to have_http_status(302)
      end
    end
  end

  context 'logged in' do
    before do
      @user = create(:user)
      @user.delete_roles
      @user.add_role :admin
      @profile = create(:profile, user: @user)
      sign_in @user
    end

    describe 'GET #index' do
      it 'return a successful response' do
        get admin_showtimes_path
        expect(response).to be_successful
      end
    end

    describe 'GET #new' do
      it 'returns a success response' do
        get new_admin_showtime_path
        expect(response).to be_successful
      end
    end

    describe 'POST #create' do
      context 'with valid parameters' do
        it 'creates a new showtime' do
          expect do
            post admin_showtimes_path, params: { showtime: valid_attributes }
          end.to change(Showtime, :count).by(1)
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          post admin_showtimes_path, params: { showtime: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid parameters' do
        it 'updates the requested showtime' do
          put admin_showtime_path(showtime), params: { showtime: valid_attributes }
          showtime.reload
          expect(showtime.fare).to eq(valid_attributes[:fare])
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          put admin_showtime_path(showtime), params: { showtime: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested showtime' do
        expect do
          delete admin_showtime_path(showtime)
        end.to change(Showtime, :count).by(-1)
      end
    end

    describe 'GET #search' do
      it 'returns a success response' do
        get search_admin_showtimes_path, params: { search_term: Faker::Lorem.word }
        expect(response).to be_successful
      end
    end
  end
end
