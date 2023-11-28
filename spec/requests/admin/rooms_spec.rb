require 'rails_helper'

RSpec.describe 'Admin::Rooms', type: :request do
  let!(:valid_attributes) { attributes_for(:room) }
  let!(:invalid_attributes) { attributes_for(:room, name: nil) }
  let!(:room) { create(:room) }

  context 'not logged in' do
    describe 'GET index' do
      it 'redirect sign in' do
        get admin_rooms_path
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
        get admin_rooms_path
        expect(response).to be_successful
      end
    end

    describe 'GET #new' do
      it 'returns a success response' do
        get new_admin_room_path
        expect(response).to be_successful
      end
    end

    describe 'POST #create' do
      context 'with valid parameters' do
        it 'creates a new room' do
          cinema = create(:cinema)
          valid_attributes[:cinema_id] = cinema.id
          expect do
            post admin_rooms_path, params: { room: valid_attributes }
          end.to change(Room, :count).by(1)
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          post admin_rooms_path, params: { room: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end

    describe 'GET #edit' do
      it 'returns a success response' do
        get edit_admin_room_path(room)
        expect(response).to be_successful
      end
    end

    describe 'PUT #update' do
      context 'with valid parameters' do
        it 'updates the requested room' do
          put admin_room_path(room), params: { room: valid_attributes }
          room.reload
          expect(room.name).to eq(valid_attributes[:name])
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          put admin_room_path(room), params: { room: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested room' do
        expect do
          delete admin_room_path(room)
        end.to change(Room, :count).by(-1)
      end
    end

    describe 'GET #search' do
      it 'returns a success response' do
        get search_admin_rooms_path, params: { search_term: Faker::Lorem.word }
        expect(response).to be_successful
      end
    end
  end
end
