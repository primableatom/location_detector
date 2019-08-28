require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :features, only: [:index, :show]
      resources :locations, only: [:create, :show]
      resources :access_tokens, only: [:index]
    end
  end
end
