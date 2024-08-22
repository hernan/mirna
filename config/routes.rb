# frozen_string_literal: true

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :users

  namespace :admin do
    get "/", to: "dashboard#index", as: "dashboard"
    get "/login", to: "auth#new", as: "login"
    post "/login", to: "auth#create"
    delete "/logout", to: "auth#delete", as: "logout"

    resources :users
    resources :customers do
      member do
        post :toggle_active
      end
    end
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "welcome#index"
end
