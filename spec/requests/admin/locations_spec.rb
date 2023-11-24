require 'rails_helper'

RSpec.describe 'Admin::Locations', type: :request do
  let(:location) { create(:location) }
  let(:valid_attributes) { attributes_for(:location) }
  let(:invalid_attributes) { attributes_for(:location, name: nil) }
  context 'not logged in' do
    describe 'GET index' do
      it 'redirect sign in' do
        get admin_locations_path
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
        get admin_locations_path
        expect(response).to have_http_status(200)
      end
    end
    describe 'GET #new' do
      it 'returns a success response' do
        get new_admin_location_path
        expect(response).to be_successful
      end
    end
    describe 'POST #create' do
      context 'with valid parameters' do
        it 'creates a new Location' do
          expect do
            post admin_locations_path, params: { location: valid_attributes }
          end.to change(Location, :count).by(1)
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          post admin_locations_path, params: { location: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end
    describe 'GET #edit' do
      it 'returns a success response' do
        get edit_admin_location_path(location)
        expect(response).to be_successful
      end
    end
    describe 'PUT #update' do
      context 'with valid parameters' do
        it 'updates the requested location' do
          put admin_location_path(location), params: { location: valid_attributes }
          location.reload
          expect(location.name).to eq(valid_attributes[:name])
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          put admin_location_path(location), params: { location: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end
    describe 'DELETE #destroy' do
      it 'deletes the requested location' do
        location = create(:location)
        expect do
          delete admin_location_path(location)
        end.to change(Location, :count).by(-1)
      end
    end
    describe 'GET #search' do
      it 'returns a success response' do
        get search_admin_locations_path, params: { search_term: Faker::Lorem.word }
        expect(response).to be_successful
      end
    end
  end
end
