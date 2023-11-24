require 'rails_helper'

RSpec.describe 'Admin::Supplies', type: :request do
  let(:cinema) { create(:cinema) }
  let(:valid_attributes) { attributes_for(:supply, cinema_id: cinema.id) }
  let(:invalid_attributes) { attributes_for(:supply, name: nil, cinema_id: cinema.id) }
  let(:supply) { create(:supply) }

  context 'not logged in' do
    describe 'GET index' do
      it 'redirect sign in' do
        get admin_supplies_path
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
        get admin_supplies_path
        expect(response).to be_successful
      end
    end

    describe 'GET #new' do
      it 'returns a success response' do
        get new_admin_supply_path
        expect(response).to be_successful
      end
    end
    describe 'POST #create' do
      context 'with valid parameters' do
        it 'creates a new supply' do
          expect do
            post admin_supplies_path, params: { supply: valid_attributes }
          end.to change(Supply, :count).by(1)
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          post admin_supplies_path, params: { supply: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end
    describe 'GET #edit' do
      it 'returns a success response' do
        get edit_admin_supply_path(supply)
        expect(response).to be_successful
      end
    end
    describe 'PUT #update' do
      context 'with valid parameters' do
        it 'updates the requested supply' do
          put admin_supply_path(supply), params: { supply: valid_attributes }
          supply.reload
          expect(supply.name).to eq(valid_attributes[:name])
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          put admin_supply_path(supply), params: { supply: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end
    describe 'DELETE #destroy' do
      it 'destroys the requested room' do
        supply
        expect do
          delete admin_supply_path(supply)
        end.to change(Supply, :count).by(-1)
      end
    end
    describe 'GET #search' do
      it 'returns a success response' do
        get search_admin_supplies_path, params: { search_term: Faker::Lorem.word }
        expect(response).to be_successful
      end
    end
  end
end
