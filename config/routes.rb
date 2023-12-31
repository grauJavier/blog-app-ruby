Rails.application.routes.draw do
  root 'users#index'

  resources :users do
    resources :posts do
      resources :comments, only: %i[new create]
      resources :likes, only: %i[new create]
    end
  end
end
