Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  namespace :admin do
    resources :structure_of_rooms
    resources :locations do
      member do
        get 'destroy_modal'
      end
    end
    resources :cinemas do
      member do
        get 'destroy_modal'
      end
    end
    resources :movies do
      member do
        get 'destroy_modal'
      end
    end
    resources :rooms do
      member do
        get 'destroy_modal'
      end
    end
    resources :showtimes do
      member do
        get 'destroy_modal'
      end
    end
    resources :users, only: [:index]
    resources :supplies do
      member do
        get 'destroy_modal'
      end
    end
  end

  namespace :customer do
    resources :tickets
  end

  resources :pages, only: :index do
    member do
      get 'movie', to: 'pages#movie_detail'
      get 'booking', to: 'pages#booking'
      get 'booking/showtimes', to: 'pages#get_showtimes'
    end
    collection do
      get 'movies/now-showing', to: 'pages#movies_now_showing'
      get 'movies/coming-soon', to: 'pages#movies_coming_soon'
    end
  end
  # Custom Error Pages
  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
