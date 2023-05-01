Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users
  root 'pages#home'

  get '/user' => "groups#index", :as => :user_root

  resources :groups do
    resources :operations
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end