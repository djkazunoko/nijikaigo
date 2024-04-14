Rails.application.routes.draw do
  resources :groups
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "groups#index"
  get "auth/:provider/callback" => "user_sessions#create"
  get "auth/failure" => "user_sessions#failure"
  delete "/logout" => "user_sessions#destroy"
end
