require 'rails_helper'

RSpec.describe 'Customer::Profiles', type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:profile, user_id: user.id) }
  let(:invalid_attributes) { attributes_for(:profile, fullname: nil, user_id: user.id) }
  let(:profile) { create(:profile, user:) }
  context 'not logged in' do
    describe 'GET edit' do
      it 'redirect sign in' do
        get edit_customer_profile_path(profile)
        expect(response).to have_http_status(302)
      end
    end
  end
  context 'logged in' do
    before do
      user.delete_roles
      user.add_role :customer
      sign_in user
    end
    describe 'GET edit' do
      it 'return a successful response' do
        get edit_customer_profile_path(profile)
        expect(response).to be_successful
      end
    end
    describe 'PUT #update' do
      context 'with valid parameters' do
        it 'updates the requested profile' do
          put customer_profile_path(profile), params: { profile: valid_attributes }
          profile.reload
          expect(profile.fullname).to eq(valid_attributes[:fullname])
        end
      end
      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          put customer_profile_path(profile), params: { profile: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
