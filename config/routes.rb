Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root 'devise/sessions#new'
  end

  resources :users do
    resources :posts do
      resources :comments, only: %i[new create]
      resources :likes, only: %i[new create]
    end
  end
end
