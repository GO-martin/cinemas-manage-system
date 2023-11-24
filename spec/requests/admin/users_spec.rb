require 'rails_helper'

RSpec.describe 'Admin::Users', type: :request do
  context 'not logged in' do
    describe 'GET index' do
      it 'redirect sign in' do
        get admin_users_path
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
        get admin_users_path
        expect(response).to be_successful
      end
    end

    describe 'GET #search' do
      it 'returns a success response' do
        get search_admin_users_path, params: { search_term: Faker::Lorem.word }
        expect(response).to be_successful
      end
    end
  end
end
