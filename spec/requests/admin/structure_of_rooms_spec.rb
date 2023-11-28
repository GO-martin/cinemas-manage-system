require 'rails_helper'

RSpec.describe 'Admin::StructureOfRooms', type: :request do
  let!(:valid_attributes) { attributes_for(:structure_of_room) }
  let!(:invalid_attributes) { attributes_for(:structure_of_room, type_seat: nil) }
  let!(:structure_of_room) { create(:structure_of_room) }

  before do
    @user = create(:user)
    @user.delete_roles
    @user.add_role :admin
    @profile = create(:profile, user: @user)
    sign_in @user
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new structure of room' do
        valid_attributes[:room_id] = structure_of_room.room.id
        expect do
          post admin_structure_of_rooms_path, params: { structure_of_room: valid_attributes }
        end.to change(StructureOfRoom, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity' do
        post admin_structure_of_rooms_path, params: { structure_of_room: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      it 'updates the requested structure of room' do
        put admin_structure_of_room_path(structure_of_room), params: { structure_of_room: valid_attributes }
        structure_of_room.reload
        expect(structure_of_room.row_index).to eq(valid_attributes[:row_index])
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity' do
        put admin_structure_of_room_path(structure_of_room), params: { structure_of_room: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end
end
