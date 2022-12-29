Rails.application.routes.draw do
  resources :users, only: %i[show create]
  post "/login", to: "sessions#create"
  get "/profile", to: "users#profile"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
