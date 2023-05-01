Rails.application.routes.draw do
  resources :groups do
    resources :operations
  end

  root "groups#index"
end