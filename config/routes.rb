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
  end

  # Custom Error Pages
  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
