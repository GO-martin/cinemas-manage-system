require 'rails_helper'

RSpec.describe 'Admin::Cinemas', type: :request do
  let!(:valid_attributes) { attributes_for(:cinema) }
  let!(:invalid_attributes) { attributes_for(:cinema, name: nil) }
  let!(:cinema) { create(:cinema) }
  context 'not logged in' do
    describe 'GET index' do
      it 'redirect sign in' do
        get admin_cinemas_path
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
        get admin_cinemas_path
        expect(response).to be_successful
      end
    end
    describe 'GET #new' do
      it 'returns a success response' do
        get new_admin_cinema_path
        expect(response).to be_successful
      end
    end
    describe 'POST #create' do
      context 'with valid parameters' do
        it 'creates a new Cinema' do
          valid_attributes[:location_id] = cinema.location.id
          expect do
            post admin_cinemas_path, params: { cinema: valid_attributes }
          end.to change(Cinema, :count).by(1)
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          post admin_cinemas_path, params: { cinema: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end

    describe 'GET #edit' do
      it 'returns a success response' do
        get edit_admin_cinema_path(cinema)
        expect(response).to be_successful
      end
    end
    describe 'PUT #update' do
      context 'with valid parameters' do
        it 'updates the requested cinema' do
          put admin_cinema_path(cinema), params: { cinema: valid_attributes }
          cinema.reload
          expect(cinema.name).to eq(valid_attributes[:name])
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          put admin_cinema_path(cinema), params: { cinema: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end
    describe 'DELETE #destroy' do
      it 'destroys the requested cinema' do
        expect do
          delete admin_cinema_path(cinema)
        end.to change(Cinema, :count).by(-1)
      end
    end
    describe 'GET #search' do
      it 'returns a success response' do
        get search_admin_cinemas_path, params: { search_term: Faker::Lorem.word }
        expect(response).to be_successful
      end
    end
  end
end
