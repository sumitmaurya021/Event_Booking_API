Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  namespace :api do
    namespace :v1 do
      resources :users
      resources :events do
        get 'analytics', to: 'event_analytics#index'
        get 'analytics/download_pdf', to: 'event_analytics#download_pdf'
      end
      resources :speakers
      resources :tickets
      resources :bookings
      post 'login', to: 'users#login'
      post 'logout', to: 'users#logout'
      get 'upcoming_events', to: 'events#upcoming_events'
      get 'search_events', to: 'events#search'
    end
  end
end
