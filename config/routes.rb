Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'questions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :questions do
    resources :scenarios, only: [:new, :create] do
      resources :bets, only: [:new, :create]
    end
  end

  namespace :dashboard do

    resources :meetings, only: [] do
      member do
      end
    end
  end
end
