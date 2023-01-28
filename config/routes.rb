Rails.application.routes.draw do
  resources :books
  resource :users, only: [:create]
  post "/login", to: "users#login"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
