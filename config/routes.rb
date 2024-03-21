Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

    namespace :api do
      namespace :v1 do
        resources :users
        post '/login', to: 'users#login'
        post '/logout', to: 'users#logout'
          resources :events do
            member do
              post 'add_speaker'
              delete 'remove_speaker'
            end
          end
        resources :speakers, only: [:index, :show, :create, :update, :destroy]
      end
    end
end
