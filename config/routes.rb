require 'sidekiq/web'

Rails.application.routes.draw do
  root 'pages#home'
  resources :payment_intents
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :notifications, only: %i[index] do
    collection do
      get 'notifications_navbar'
      post 'view_all'
    end
  end

  concern :searchable do
    collection do
      get 'search'
    end
  end

  namespace :admin do
    resources :notifications
    resources :dashboards do
      collection do
        get 'update_main_chart'
        get 'update_stats'
      end
    end
    resources :profiles
    resources :structure_of_rooms
    resources :locations do
      concerns :searchable
      member do
        get 'destroy_modal'
      end
    end
    resources :cinemas do
      concerns :searchable
      member do
        get 'destroy_modal'
      end
    end
    resources :movies do
      concerns :searchable
      member do
        get 'destroy_modal'
        put 'change_now_showing'
        put 'change_coming_soon'
      end
    end
    resources :rooms do
      concerns :searchable
      member do
        get 'destroy_modal'
      end
    end
    resources :showtimes do
      concerns :searchable
      member do
        get 'destroy_modal'
      end
    end
    resources :users do
      concerns :searchable
    end
    resources :supplies do
      concerns :searchable
      member do
        get 'destroy_modal'
      end
    end
    resources :tickets do
      concerns :searchable
    end
  end

  namespace :customer do
    mount Sidekiq::Web => '/sidekiq'
    resources :profiles
    resources :tickets
    resources :showtimes
    resources :rooms
    resources :supplies do
      collection do
        get 'booking/supplies', to: 'supplies#booking_supplies'
      end
    end
    resources :ticket_supplies
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
