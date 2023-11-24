require 'rails_helper'

RSpec.describe 'Admin::Movies', type: :request do
  let(:valid_attributes) { attributes_for(:movie) }
  let(:invalid_attributes) { attributes_for(:movie, name: nil) }
  let(:movie) { create(:movie) }

  context 'not logged in' do
    describe 'GET index' do
      it 'redirect sign in' do
        get admin_movies_path
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
        get admin_movies_path
        expect(response).to be_successful
      end
    end
    describe 'GET #new' do
      it 'returns a success response' do
        get new_admin_movie_path
        expect(response).to be_successful
      end
    end
    describe 'POST #create' do
      context 'with valid parameters' do
        it 'creates a new movie' do
          expect do
            post admin_movies_path, params: { movie: valid_attributes }
          end.to change(Movie, :count).by(1)
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          post admin_movies_path, params: { movie: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end
    describe 'GET #edit' do
      it 'returns a success response' do
        get edit_admin_movie_path(movie)
        expect(response).to be_successful
      end
    end
    describe 'PUT #update' do
      context 'with valid parameters' do
        it 'updates the requested movie' do
          put admin_movie_path(movie), params: { movie: valid_attributes }
          movie.reload
          expect(movie.name).to eq(valid_attributes[:name])
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable entity' do
          put admin_movie_path(movie), params: { movie: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end
    describe 'DELETE #destroy' do
      it 'destroys the requested movie' do
        movie
        expect do
          delete admin_movie_path(movie)
        end.to change(Movie, :count).by(-1)
      end
    end
    describe 'GET #search' do
      it 'returns a success response' do
        get search_admin_movies_path, params: { search_term: Faker::Lorem.word }
        expect(response).to be_successful
      end
    end
    describe 'PUT #change_now_showing' do
      it 'updates status' do
        movie
        put change_now_showing_admin_movie_path(movie)
        movie.reload
        expect(movie.status).to eq('now_showing')
      end
    end
    describe 'PUT #change_now_showing' do
      it 'updates status' do
        movie
        put change_coming_soon_admin_movie_path(movie)
        movie.reload
        expect(movie.status).to eq('coming_soon')
      end
    end
  end
end
